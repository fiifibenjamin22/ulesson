//
//  LessonDetailController.swift
//  Ulessons
//
//  Created by Benjamin Acquah on 9/30/21.
//

import UIKit
import CoreData

class LiveLessonController: AppViewControllerClass,UICollectionViewDelegate,UICollectionViewDataSource {
    
    enum Section: Hashable {
        case items
    }
    
    var viewModel = LessonsListViewModel()
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()
    
    private let filterPickerOptions: [Filter] = [.ALL_SUBJECT, .MATHEMATICS, .ENGLISH, .CHEMISTRY, .BIOLOGY, .PHYSICS]
    private var floatingButton = UIButton().manualLayoutable()
    var lessonViewModel = [LessonViewModel]()
    
    private lazy var filterPickerCallback: (Int) -> Void = { [unowned self] selectedFilterIndex in
        let selectedFilter = self.filterPickerOptions[selectedFilterIndex]
        print(selectedFilter)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
        fetchData()
        let _ = Lessons()
    }
    
    private func setup() {
        extendedLayoutIncludesOpaqueBars = true
        setupCollectionView()
        setUpViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        adjustNavigationBar()
    }
    
    func setUpViews() {
        self.view.backgroundColor = .white
        setUpProperties()
        setupHierarchy()
        setUpAutoLayout()
    }
    
    fileprivate func fetchData(){
        viewModel.fetchLessons { [weak self] (success) in
            
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
        }
    }

}

extension LiveLessonController: UICollectionViewDelegateFlowLayout,DropDownDelegate {
    
    private func setupCollectionView() {
        collectionView.register(LiveLessonsViewCell.self, forCellWithReuseIdentifier: Strings.liveCellId.rawValue)
        collectionView.register(EmptyLiveCell.self, forCellWithReuseIdentifier: Strings.emptyLiveCellId.rawValue)
        collectionView.register(LiveLessonsHeaderCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: Strings.headerCellId.rawValue)
        collectionView.showsVerticalScrollIndicator = true
        collectionView.backgroundColor = .appTextWhite
        collectionView.delegate = self
        collectionView.dataSource = self
        view.addSubview(collectionView)
        collectionView.edgesToParent(anchors: [.top, .leading, .trailing, .bottom], insets: UIEdgeInsets(top: 0, bottom: 0, left: 0, right: 0))
    }
    
    private func adjustNavigationBar() {
        title = "Live Lessons".localized.uppercased()
        statusBar?.backgroundColor = .white
        navigationController?.setNavigationBarHidden(false, animated: false)
        navigationController?.setShadowBarEnabled(false)
        navigationController?.applyWhiteTheme()
    }
    
    private func setUpProperties() {
        floatingButton.apply {
            $0.setImage(Icons.Common.warning.withRenderingMode(.alwaysTemplate), for: .normal)
            $0.clipsToBounds = true
            $0.layer.cornerRadius = Constants.ButtonView.width / 2
            $0.backgroundColor = .systemBlue
            $0.tintColor = .white
            $0.addShadow()
        }
    }
    
    private func setupHierarchy() {
        self.view.addSubview(floatingButton)
        floatingButton.addTarget(self, action: #selector(gotoMyLessons), for: .touchUpInside)
    }
    
    private func setUpAutoLayout() {
        floatingButton.apply {
            $0.bottomAnchor.equal(to: view.bottomAnchor, constant: -30).activate()
            $0.trailingAnchor.equal(to: view.trailingAnchor, constant: -16).activate()
            $0.heightAnchor.equalTo(constant: Constants.ButtonView.width).activate()
            $0.widthAnchor.equalTo(constant: Constants.ButtonView.width).activate()
        }
    }
    
    @objc func gotoMyLessons() {
        navigate(using: .lesson(lesson: lessonViewModel))
    }
    
    private func navigate(using destination: LessonDestination) {
        switch destination {
        case .lesson:
            router.push(destination: destination)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.rowsCount == 0 ? 1 : self.viewModel.rowsCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if self.viewModel.rowsCount == 0  {
            let emptyCell = collectionView.dequeueReusableCell(withReuseIdentifier: Strings.emptyLiveCellId.rawValue, for: indexPath) as! EmptyLiveCell
            return emptyCell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Strings.liveCellId.rawValue, for: indexPath) as! LiveLessonsViewCell
            cell.configureCell(forLessons: viewModel.lessonsViewModels[indexPath.row])
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: Strings.headerCellId.rawValue, for: indexPath) as! LiveLessonsHeaderCell
        headerView.delegate = self
        return headerView
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return self.viewModel.rowsCount == 0 ? CGSize(width: self.view.frame.size.width, height: self.view.frame.size.width) : CGSize(width: self.view.frame.size.width, height: 150)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: self.view.frame.size.width, height: 320)
    }
    
    func showDropdownMenu(menuTopConstant: CGFloat) {
        showFilterSelector(withSelected: .ALL_SUBJECT, menuTopConstant: menuTopConstant)
    }
    
    private func showFilterSelector(withSelected selected: Filter, menuTopConstant: CGFloat) {
        let controller = DropDownPopupViewController(
            with: DropDownData(
                icon: nil,
                title: Strings.selectFilter.localized,
                popupTitle: Strings.selectFilter.localized,
                options: filterPickerOptions
            ),
            selectedOption: selected, menuTopConstant: menuTopConstant).apply { $0.selectionCallback = filterPickerCallback }
        
        controller.modalTransitionStyle = .crossDissolve
        controller.modalPresentationStyle = .overFullScreen
        present(controller, animated: true, completion: nil)
    }
}
