//
//  LessonsViewCell.swift
//  Ulessons
//
//  Created by Benjamin Acquah on 9/30/21.
//

import UIKit

class LessonViewCell: UICollectionViewCell {
    
    var width: CGFloat = 90
    var widthConstant: NSLayoutConstraint?
    
    var lessonViewModel: LessonViewModel! {
        didSet {
            guard let url = URL(string: lessonViewModel.imageUrl) else { return }
            guard let data = try? Data(contentsOf: url) else { return }
            lessonImage.image = UIImage(data: data)
            subjectLabel.text = lessonViewModel.subject.name
            timeLabel.text = "\(lessonViewModel.getDate())"
            lessonStateLabel.text = "• \(lessonViewModel.status)".uppercased()
            lessonTitleLabel.text = lessonViewModel.topic
            lessonStateLabel.backgroundColor = lessonViewModel.status  == "upcoming" ? .systemGray : lessonViewModel.status  == "live" ? .systemRed : .systemOrange
            widthConstant?.constant = lessonViewModel.status  == "upcoming" ? 110 : lessonViewModel.status  == "live" ? 70 : 90
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
            $0.addShadow()
            $0.animateEntrance()
            $0.backgroundColor = .appTextWhite
        }
        
        self.addSubview(baseView)
        
        baseView.apply {
            $0.topAnchor.equal(to: topAnchor, constant: 8).activate()
            $0.leadingAnchor.equal(to: leadingAnchor, constant: 8).activate()
            $0.trailingAnchor.equal(to: trailingAnchor, constant: -8).activate()
            $0.heightAnchor.equalTo(constant: 306).activate()
        }
        
        lessonImage.apply {
            $0.clipsToBounds = true
            $0.roundCorners()
            $0.backgroundColor = .appBlack
            $0.contentMode = .scaleAspectFill
        }
        
        self.baseView.addSubview(lessonImage)
        
        lessonImage.apply {
            $0.topAnchor.equal(to: topAnchor, constant: 8).activate()
            $0.leadingAnchor.equal(to: leadingAnchor, constant: 8).activate()
            $0.trailingAnchor.equal(to: trailingAnchor, constant: -8).activate()
            $0.heightAnchor.equalTo(constant: 200).activate()
        }
        
        lessonStateLabel.apply {
            $0.backgroundColor = .appGrey
            $0.text = "Upcoming".uppercased()
            $0.textAlignment = .center
            $0.font = UIFont.custom(ofSize: Constants.FontSize.body, font: UIFont.Roboto.medium)
            $0.lineHeight = Constants.NameLabel.lineHeight
            $0.textColor = UIColor.appTextWhite
            $0.numberOfLines = Constants.NameLabel.numberOfLines
            $0.roundCorners()
        }
        
        self.lessonImage.addSubview(lessonStateLabel)
        
        lessonStateLabel.apply {
            $0.trailingAnchor.equal(to: lessonImage.trailingAnchor, constant: -10).activate()
            $0.topAnchor.equal(to: lessonImage.topAnchor, constant: 12).activate()
            widthConstant = $0.widthAnchor.equalTo(constant: 90).activate()
            $0.heightAnchor.equalTo(constant: 35).activate()
        }
        
        lessonMessageImage.apply {
            $0.backgroundColor = .appTextWhite
        }
        
        self.lessonImage.addSubview(lessonMessageImage)
        
        lessonMessageImage.apply {
            $0.leadingAnchor.equal(to: lessonImage.leadingAnchor, constant: 10).activate()
            $0.topAnchor.equal(to: lessonImage.topAnchor, constant: 12).activate()
            $0.widthAnchor.equalTo(constant: 30).activate()
            $0.heightAnchor.equalTo(constant: 30).activate()
        }
        
        subjectLabel.apply {
            $0.text = "Physics"
            $0.font = UIFont.custom(ofSize: Constants.FontSize.small, font: UIFont.Roboto.regular)
            $0.lineHeight = Constants.NameLabel.lineHeight
            $0.textColor = UIColor.appTextMediumBright
            $0.numberOfLines = Constants.NameLabel.numberOfLines
        }
        
        self.baseView.addSubview(subjectLabel)
        
        subjectLabel.apply {
            $0.topAnchor.equal(to: lessonImage.bottomAnchor, constant: 4).activate()
            $0.leadingAnchor.equal(to: lessonImage.leadingAnchor, constant: 16).activate()
            $0.trailingAnchor.equal(to: lessonImage.trailingAnchor, constant: -16).activate()
            $0.heightAnchor.equalTo(constant: 30).activate()
        }
        
        timeImage.apply {
            $0.image = Icons.Common.checkedBig
            $0.clipsToBounds = true
            $0.layer.cornerRadius = Constants.ClockImageView.height / 2
        }
        
        self.baseView.addSubview(timeImage)
        
        timeImage.apply {
            $0.topAnchor.equal(to: subjectLabel.bottomAnchor, constant: 4).activate()
            $0.leadingAnchor.equal(to: subjectLabel.leadingAnchor, constant: 0).activate()
            $0.widthAnchor.equalTo(constant: 20).activate()
            $0.heightAnchor.equalTo(constant: 20).activate()
        }
        
        timeLabel.apply {
            $0.text = "Started at 3:30 PM"
            $0.font = UIFont.custom(ofSize: Constants.FontSize.small, font: UIFont.Roboto.regular)
            $0.lineHeight = Constants.NameLabel.lineHeight
            $0.textColor = UIColor.appTextMediumBright
            $0.numberOfLines = Constants.NameLabel.numberOfLines
        }
        
        self.baseView.addSubview(timeLabel)
        
        timeLabel.apply {
            $0.topAnchor.equal(to: timeImage.topAnchor, constant: -6).activate()
            $0.leadingAnchor.equal(to: timeImage.trailingAnchor, constant: 8).activate()
            $0.trailingAnchor.equal(to: subjectLabel.trailingAnchor, constant: -16).activate()
            $0.bottomAnchor.equal(to: timeImage.bottomAnchor, constant: 0).activate()
        }
        
        lessonTitleLabel.apply {
            $0.text = "Materials - Metals & Non Metals"
            $0.font = UIFont.custom(ofSize: Constants.FontSize.smallTitle, font: UIFont.Roboto.bold)
            $0.lineHeight = Constants.NameLabel.lineHeight
            $0.textColor = UIColor.appTextMediumBright
            $0.numberOfLines = Constants.NameLabel.numberOfLines
        }
        
        self.baseView.addSubview(lessonTitleLabel)
        
        lessonTitleLabel.apply {
            $0.topAnchor.equal(to: timeImage.bottomAnchor, constant: 4).activate()
            $0.leadingAnchor.equal(to: timeImage.leadingAnchor, constant: 0).activate()
            $0.trailingAnchor.equal(to: subjectLabel.trailingAnchor, constant: -16).activate()
            $0.bottomAnchor.equal(to: self.bottomAnchor, constant: -4).activate()
        }
    }
}
