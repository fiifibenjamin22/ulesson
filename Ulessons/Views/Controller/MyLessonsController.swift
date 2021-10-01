//
//  ViewController.swift
//  Ulessons
//
//  Created by Benjamin Acquah on 9/28/21.
//

import UIKit

class MyLessonsViewVC: AppViewControllerClass,UICollectionViewDelegate,UICollectionViewDataSource {
    
    var lessonViewModel = [LessonViewModel]()
    
//    init(myLessons: [LessonViewModel]) {
//        self.lessonViewModel = myLessons
//        super.init(nibName: nil, bundle: nil)
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()
    
    private var barStyle: UIStatusBarStyle = .default
    private var dropDownButton = UIButton().manualLayoutable()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
        
        print(lessonViewModel)
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
}

extension MyLessonsViewVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.lessonViewModel.isEmpty ? 1 : self.lessonViewModel.count
        //return lessonViewModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if self.lessonViewModel.isEmpty  {
            let emptyCell = collectionView.dequeueReusableCell(withReuseIdentifier: Strings.emptyLiveCellId.rawValue, for: indexPath) as! EmptyLiveCell
            emptyCell.isEmptyLabel.text = "Your timetable is empty"
            emptyCell.isEmptyDescriptionLabel.text = "Click remind me to add lessons to your timetable"
            emptyCell.backGroundImage.image = Icons.Common.calender
            return emptyCell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Strings.cellId.rawValue, for: indexPath) as! LessonViewCell
            cell.lessonViewModel = lessonViewModel[indexPath.item]
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: Strings.footerCellId.rawValue, for: indexPath) as! MyLessonsFooterCell
        return footerView
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    private func setupCollectionView() {
        collectionView.register(LessonViewCell.self, forCellWithReuseIdentifier: Strings.cellId.rawValue)
        collectionView.register(EmptyLiveCell.self, forCellWithReuseIdentifier: Strings.emptyLiveCellId.rawValue)
        collectionView.register(MyLessonsFooterCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: Strings.footerCellId.rawValue)
        collectionView.showsVerticalScrollIndicator = true
        collectionView.backgroundColor = .appTextWhite
        collectionView.delegate = self
        collectionView.dataSource = self
        view.addSubview(collectionView)
        collectionView.edgesToParent(anchors: [.top, .leading, .trailing, .bottom], insets: UIEdgeInsets(top: 170, bottom: 0, left: 0, right: 0))
    }
    
    private func adjustNavigationBar() {
        title = "My Lessons".localized.uppercased()
        statusBar?.backgroundColor = .white
        navigationController?.setNavigationBarHidden(false, animated: false)
        navigationController?.setShadowBarEnabled(false)
        navigationController?.applyWhiteTheme()
    }
    
    private func setUpProperties() {
        dropDownButton.apply {
            $0.setTitle("All Subject", for: .normal)
            $0.backgroundColor = .appBlack
            $0.roundCorners()
            $0.clipsToBounds = true
        }
    }
    
    private func setupHierarchy() {
        self.view.addSubview(dropDownButton)
    }
    
    private func setUpAutoLayout() {
        dropDownButton.apply {
            $0.topAnchor.equal(to: view.topAnchor, constant: 110).activate()
            $0.leftAnchor.equal(to: view.leftAnchor, constant: 8).activate()
            $0.widthAnchor.equalTo(constant: 150).activate()
            $0.heightAnchor.equalTo(constant: 35).activate()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return self.lessonViewModel.isEmpty ? CGSize(width: self.view.frame.size.width, height: self.view.frame.size.width) : CGSize(width: self.view.frame.size.width, height: 315)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: self.view.frame.size.width, height: 120)
    }
}

private extension Constants {
    enum MyLessonsViewVC {
        static let tableSeparatorInsets = UIEdgeInsets(side: 16)
    }
}

