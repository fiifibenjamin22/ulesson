//
//  LiveLessonsHeaderCell.swift
//  Ulessons
//
//  Created by Benjamin Acquah on 9/30/21.
//

import UIKit

import UIKit

class LiveLessonsHeaderCell: UICollectionViewCell,UICollectionViewDelegate,UICollectionViewDataSource {
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()
    
    let paginator = UIPageControl().manualLayoutable()
    private var dropDownButton = UIButton().manualLayoutable()
    var promoViewModel = [PromoViewModel]()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCollectionView()
        fetchData()
    }
    
    fileprivate func fetchData(){
        Service.shared.fetchPromotion { lessons, err in
            if let err = err {
                print("Failed to fetch courses:", err.localizedDescription)
                return
            }
            let filteredLessons = lessons?.filter { $0.status == "live" }
            self.promoViewModel = filteredLessons?.map({ return PromoViewModel(lesson: $0) }) ?? []
            self.collectionView.reloadData()
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
            $0.numberOfPages = 3
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
        return self.promoViewModel.prefix(3).count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Strings.liveCellId.rawValue, for: indexPath) as! HCellViewCell
        cell.promoViewModel = promoViewModel[indexPath.item]
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
}
