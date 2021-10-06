//
//  LiveLessonsHeaderCell.swift
//  Ulessons
//
//  Created by Benjamin Acquah on 9/30/21.
//

import UIKit

protocol DropDownDelegate {
    func showDropdownMenu(menuTopConstant: CGFloat)
}
class LiveLessonsHeaderCell: UICollectionViewCell,UICollectionViewDelegate,UICollectionViewDataSource {
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()
    
    var viewModel = PromoListViewModel()
    
    let paginator = UIPageControl().manualLayoutable()
    var delegate: DropDownDelegate?
    private var dropDownButton: UIButton = {
        var filled = UIButton.Configuration.filled()
        filled.title = "Filter"
        filled.buttonSize = .large
        filled.image = Icons.Common.dropdown
        filled.imagePlacement = .trailing
        filled.imagePadding = 5
        filled.baseBackgroundColor = .init(hexString: "#313848")

        let button = UIButton(configuration: filled, primaryAction: nil)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    var promoViewModel = [PromoViewModel]()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCollectionView()
        fetchData()
    }
    
    fileprivate func fetchData(){
        viewModel.fetchPromos { [weak self] (success) in
            
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension LiveLessonsHeaderCell: UICollectionViewDelegateFlowLayout {
    
    private func setupCollectionView() {
        collectionView.register(HCellViewCell.self, forCellWithReuseIdentifier: Strings.liveCellId.rawValue)
        collectionView.backgroundColor = .appTextWhite
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        self.addSubview(collectionView)
        collectionView.edgesToParent(anchors: [.top, .leading, .trailing, .bottom], insets: UIEdgeInsets(top: 0, bottom: 90, left: 0, right: 0))
        
        paginator.apply {
            $0.currentPage = 0
            $0.numberOfPages = 1
            $0.currentPageIndicatorTintColor = .systemGray
            $0.pageIndicatorTintColor = .systemFill
        }
        
        self.addSubview(paginator)
        
        paginator.apply {
            $0.topAnchor.equal(to: collectionView.bottomAnchor, constant: 0).activate()
            $0.centerXAnchor.equal(to: self.centerXAnchor).activate()
            $0.widthAnchor.equalTo(constant: 200).activate()
            $0.heightAnchor.equalTo(constant: 30).activate()
        }
        
        dropDownButton.apply {
            $0.setTitle("All Subject", for: .normal)
            $0.backgroundColor = .appBlack
            $0.roundCorners()
            $0.clipsToBounds = true
            $0.addTarget(self, action: #selector(handleFilterSelections), for: .touchUpInside)
        }
        
        self.addSubview(dropDownButton)
        
        dropDownButton.apply {
            $0.topAnchor.equal(to: paginator.bottomAnchor, constant: 8).activate()
            $0.leftAnchor.equal(to: leftAnchor, constant: 8).activate()
            $0.widthAnchor.equalTo(constant: 150).activate()
            $0.heightAnchor.equalTo(constant: 35).activate()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.rowsCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Strings.liveCellId.rawValue, for: indexPath) as! HCellViewCell
        cell.configureCell(forLessons: viewModel.promoViewModels[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.frame.size.width, height: 210)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        coordinator.animate(alongsideTransition: { (_) in
            self.collectionView.invalidateIntrinsicContentSize()
            if (self.paginator.currentPage == 0){
                self.collectionView.contentOffset = .zero
            }else{
                let indexPath = IndexPath(item: self.paginator.currentPage, section: 0)
                self.collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            }
        }, completion: {(bear_) in
            
        })
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
       let x = targetContentOffset.pointee.x
       paginator.currentPage = Int(x/self.frame.width)
   }
    
    @objc private func handleFilterSelections() {
        self.delegate?.showDropdownMenu(menuTopConstant: 350)
    }
}
