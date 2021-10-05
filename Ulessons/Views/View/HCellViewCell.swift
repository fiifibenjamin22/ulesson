//
//  HCellViewCell.swift
//  Ulessons
//
//  Created by Benjamin Acquah on 9/30/21.
//

import UIKit

class HCellViewCell: UICollectionViewCell {
    
    var promoViewModel: PromoViewModel! {
        didSet {
            guard let url = URL(string: promoViewModel.imageUrl) else { return }
            let data = try? Data(contentsOf: url)
            lessonImage.image = UIImage(data: data!)
            subjectLabel.text = promoViewModel.subject.name
            timeLabel.text = "\(promoViewModel.getDate()) • \(promoViewModel.tutor.firstname) \(promoViewModel.getLastName())"
            lessonStateLabel.text = "• \(promoViewModel.status)"
        }
    }
    
    private var baseView = UIView().manualLayoutable()
    private var lessonImage = UIImageView().manualLayoutable()
    private var subjectLabel = LessonsLabel().manualLayoutable()
    private var timeImage = UIImageView().manualLayoutable()
    private var timeLabel = LessonsLabel().manualLayoutable()
    private var lessonTitleLabel = LessonsLabel().manualLayoutable()
    private var lessonStateLabel = LessonsLabel().manualLayoutable()
    private var lessonMessageImage = UIImageView().manualLayoutable()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .appBackground
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        
        baseView.apply {
            $0.roundCorners()
            //$0.addShadow()
            $0.animateEntrance()
            $0.backgroundColor = .appTextWhite
        }
        
        self.addSubview(baseView)
        
        baseView.apply {
            $0.topAnchor.equal(to: topAnchor, constant: 8).activate()
            $0.leadingAnchor.equal(to: leadingAnchor, constant: 8).activate()
            $0.trailingAnchor.equal(to: trailingAnchor, constant: -8).activate()
            $0.heightAnchor.equalTo(constant: 200).activate()
        }
        
        lessonImage.apply {
            $0.clipsToBounds = true
            $0.roundCorners()
            $0.contentMode = .scaleAspectFill
            $0.backgroundColor = .appTextWhite
        }
        
        self.baseView.addSubview(lessonImage)
        
        lessonImage.apply {
            $0.topAnchor.equal(to: topAnchor, constant: 8).activate()
            $0.leadingAnchor.equal(to: leadingAnchor, constant: 8).activate()
            $0.trailingAnchor.equal(to: trailingAnchor, constant: -8).activate()
            $0.heightAnchor.equalTo(constant: 200).activate()
        }
        
        timeImage.apply {
            $0.image = Icons.Common.checkedBig
            $0.clipsToBounds = true
            $0.layer.cornerRadius = Constants.ClockImageView.height / 2
            $0.backgroundColor = .black.withAlphaComponent(0.4)
        }
        
        self.baseView.addSubview(timeImage)
        
        timeImage.apply {
            $0.bottomAnchor.equal(to: lessonImage.bottomAnchor, constant: -8).activate()
            $0.leadingAnchor.equal(to: lessonImage.leadingAnchor, constant: 8).activate()
            $0.widthAnchor.equalTo(constant: 20).activate()
            $0.heightAnchor.equalTo(constant: 20).activate()
        }
        
        timeLabel.apply {
            $0.text = "Started at 3:30 PM • Gabriella Adeboye"
            $0.font = UIFont.custom(ofSize: Constants.FontSize.small, font: UIFont.Roboto.regular)
            $0.lineHeight = Constants.NameLabel.lineHeight
            $0.textColor = UIColor.white
            $0.numberOfLines = Constants.NameLabel.numberOfLines
            $0.backgroundColor = .black.withAlphaComponent(0.4)
        }
        
        self.baseView.addSubview(timeLabel)
        
        timeLabel.apply {
            $0.topAnchor.equal(to: timeImage.topAnchor, constant: -6).activate()
            $0.leadingAnchor.equal(to: timeImage.trailingAnchor, constant: 8).activate()
            $0.trailingAnchor.equal(to: lessonImage.trailingAnchor, constant: -16).activate()
            $0.bottomAnchor.equal(to: timeImage.bottomAnchor, constant: 0).activate()
        }
                
        lessonTitleLabel.apply {
            $0.text = "Materials - Metals & Non Metals"
            $0.font = UIFont.custom(ofSize: Constants.FontSize.smallTitle, font: UIFont.Roboto.bold)
            $0.lineHeight = Constants.NameLabel.lineHeight
            $0.textColor = UIColor.white
            $0.numberOfLines = Constants.NameLabel.numberOfLines
            $0.backgroundColor = .black.withAlphaComponent(0.4)
        }
        
        self.baseView.addSubview(lessonTitleLabel)
        
        lessonTitleLabel.apply {
            $0.bottomAnchor.equal(to: timeImage.topAnchor, constant: -8).activate()
            $0.leadingAnchor.equal(to: timeImage.leadingAnchor, constant: 0).activate()
            $0.trailingAnchor.equal(to: lessonImage.trailingAnchor, constant: -16).activate()
            $0.heightAnchor.equalTo(constant: 25).activate()
        }
        
        lessonStateLabel.apply {
            $0.backgroundColor = .systemRed
            $0.text = "• Live"
            $0.textAlignment = .center
            $0.font = UIFont.custom(ofSize: Constants.FontSize.subtitle, font: UIFont.Roboto.medium)
            $0.lineHeight = Constants.NameLabel.lineHeight
            $0.textColor = UIColor.appTextWhite
            $0.numberOfLines = Constants.NameLabel.numberOfLines
            $0.roundCorners()
        }
        
        self.baseView.addSubview(lessonStateLabel)
        
        lessonStateLabel.apply {
            $0.bottomAnchor.equal(to: lessonTitleLabel.topAnchor, constant: -8).activate()
            $0.leadingAnchor.equal(to: lessonTitleLabel.leadingAnchor, constant: 0).activate()
            $0.widthAnchor.equalTo(constant: 70).activate()
            $0.heightAnchor.equalTo(constant: 25).activate()
        }
    }
}
