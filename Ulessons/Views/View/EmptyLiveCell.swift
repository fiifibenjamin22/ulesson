//
//  EmptyLiveCell.swift
//  Ulessons
//
//  Created by Benjamin Acquah on 10/1/21.
//

import UIKit

class EmptyLiveCell: UICollectionViewCell {
    
    let baseView = UIView().manualLayoutable()
    let backGroundImage = UIImageView().manualLayoutable()
    let isEmptyLabel = LessonsLabel().manualLayoutable()
    let isEmptyDescriptionLabel = LessonsLabel().manualLayoutable()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        baseView.apply {
            $0.backgroundColor = .appTextWhite
            $0.roundCorners()
            $0.addShadow()
        }
        
        addSubview(baseView)
        
        baseView.apply {
            $0.centerXAnchor.equal(to: self.centerXAnchor, constant: 0).activate()
            $0.topAnchor.equal(to: self.topAnchor, constant: 30).activate()
            $0.widthAnchor.equalTo(constant: self.frame.size.width - 32).activate()
            $0.heightAnchor.equalTo(constant: self.frame.size.width / 1.5).activate()
        }
        
        backGroundImage.apply {
            $0.image = Icons.Common.noLiveLessons
            $0.contentMode = .scaleAspectFit
        }
        
        baseView.addSubview(backGroundImage)
        
        backGroundImage.apply {
            $0.centerXAnchor.equal(to: self.baseView.centerXAnchor).activate()
            $0.topAnchor.equal(to: self.baseView.topAnchor, constant: 16).activate()
            $0.widthAnchor.equalTo(constant: 120).activate()
            $0.heightAnchor.equalTo(constant: 120).activate()
        }
        
        isEmptyLabel.apply {
            $0.text = "Oops! Try again later"
            $0.font = UIFont.custom(ofSize: Constants.FontSize.title, font: UIFont.Helvetica.bold)
            $0.lineHeight = Constants.NameLabel.lineHeight
            $0.textColor = .appBlack
            $0.textAlignment = .center
            $0.numberOfLines = Constants.NameLabel.numberOfLines
        }
        
        baseView.addSubview(isEmptyLabel)
        
        isEmptyLabel.apply {
            $0.topAnchor.equal(to: backGroundImage.bottomAnchor, constant: 0).activate()
            $0.leadingAnchor.equal(to: baseView.leadingAnchor, constant: 0).activate()
            $0.trailingAnchor.equal(to: baseView.trailingAnchor, constant: 0).activate()
            $0.heightAnchor.equalTo(constant: 40).activate()
        }
        
        isEmptyDescriptionLabel.apply {
            $0.text = "There are no live lessons for this subject at the moment"
            $0.font = UIFont.custom(ofSize: Constants.FontSize.subtitle, font: UIFont.Roboto.regular)
            $0.lineHeight = Constants.NameLabel.lineHeight
            $0.textColor = .systemGray2
            $0.textAlignment = .center
            $0.numberOfLines = Constants.NameLabel.numberOfLines
        }
        
        baseView.addSubview(isEmptyDescriptionLabel)
        
        isEmptyDescriptionLabel.apply {
            $0.topAnchor.equal(to: isEmptyLabel.bottomAnchor, constant: 0).activate()
            $0.leadingAnchor.equal(to: isEmptyLabel.leadingAnchor, constant: 8).activate()
            $0.trailingAnchor.equal(to: isEmptyLabel.trailingAnchor, constant: -8).activate()
            $0.heightAnchor.equalTo(constant: 50).activate()
        }

    }
}
