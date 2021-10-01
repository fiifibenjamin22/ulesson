//
//  MyLessonsFooterCell.swift
//  Ulessons
//
//  Created by Benjamin Acquah on 10/1/21.
//

import UIKit

class MyLessonsFooterCell: UICollectionViewCell {
    
    private var addLessonButton = UIButton().manualLayoutable()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        addSubview(addLessonButton)
        addLessonButton.apply {
            $0.setBackgroundImage(Icons.Common.addLessons, for: .normal)
            $0.roundCorners()
            
            $0.centerXAnchor.equal(to: self.centerXAnchor, constant: 0).activate()
            $0.centerYAnchor.equal(to: self.centerYAnchor, constant: 0).activate()
            $0.widthAnchor.equalTo(constant: self.frame.width - 60).activate()
            $0.heightAnchor.equalTo(constant: 60).activate()
        }
    }
}
