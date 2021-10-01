//
//  HCell.swift
//  Ulessons
//
//  Created by Benjamin Acquah on 9/30/21.
//

import UIKit

class HCellView: UICollectionViewCell,UICollectionViewDelegate,UICollectionViewDataSource {
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension HCellView: UICollectionViewDelegateFlowLayout {
    
    private func setupCollectionView() {
        collectionView.register(HCellViewCell.self, forCellWithReuseIdentifier: Strings.liveCellId.rawValue)
        collectionView.showsVerticalScrollIndicator = true
        collectionView.backgroundColor = .appTextWhite
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isPagingEnabled = true
        self.addSubview(collectionView)
        collectionView.edgesToParent(anchors: [.top, .leading, .trailing, .bottom], insets: UIEdgeInsets(top: 0, bottom: 0, left: 0, right: 0))
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Strings.liveCellId.rawValue, for: indexPath) as! HCellViewCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.frame.size.width, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
}
