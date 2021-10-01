//
//  LessonDetailController.swift
//  Ulessons
//
//  Created by Benjamin Acquah on 9/30/21.
//

import UIKit

class LiveLessonController: AppViewControllerClass,UICollectionViewDelegate,UICollectionViewDataSource {
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()
    
    private var floatingButton = UIButton().manualLayoutable()
    var lessonViewModel = [LessonViewModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
        //fetchData()
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
        Service.shared.fetchPromotion { lessons, err in
            if let err = err {
                print("Failed to fetch courses:", err.localizedDescription)
                return
            }
            //let filteredUpcomingLessons = lessons?.filter { $0.status != "live" }
            self.lessonViewModel = lessons?.map({ return LessonViewModel(lesson: $0) }) ?? []
            self.collectionView.reloadData()
        }
    }

}

extension LiveLessonController: UICollectionViewDelegateFlowLayout {
    
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
       return self.lessonViewModel.isEmpty ? 1 : self.lessonViewModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if self.lessonViewModel.isEmpty  {
            let emptyCell = collectionView.dequeueReusableCell(withReuseIdentifier: Strings.emptyLiveCellId.rawValue, for: indexPath) as! EmptyLiveCell
            return emptyCell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Strings.liveCellId.rawValue, for: indexPath) as! LiveLessonsViewCell
            cell.lessonViewModel = self.lessonViewModel[indexPath.item]
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: Strings.headerCellId.rawValue, for: indexPath) as! LiveLessonsHeaderCell
        return headerView
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return self.lessonViewModel.isEmpty ? CGSize(width: self.view.frame.size.width, height: self.view.frame.size.width) : CGSize(width: self.view.frame.size.width, height: 150)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: self.view.frame.size.width, height: 320)
    }
}
