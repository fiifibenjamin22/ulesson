//
//  LIveLessonsViewCell.swift
//  Ulessons
//
//  Created by Benjamin Acquah on 9/30/21.
//

import UIKit

class LiveLessonsViewCell: UICollectionViewCell {
    
    var width: CGFloat = 90
    var widthConstant: NSLayoutConstraint?
    
    private var lessonImage = UIImageView().manualLayoutable()
    private var lessonStateLabel = LessonsLabel().manualLayoutable()

    private var subjectLabel = LessonsLabel().manualLayoutable()
    private var timeImage = UIImageView().manualLayoutable()
    private var timeLabel = LessonsLabel().manualLayoutable()
    private var lessonTitleLabel = LessonsLabel().manualLayoutable()
    private var userImage = UIImageView().manualLayoutable()
    private var lessonTutorLabel = LessonsLabel().manualLayoutable()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .appBackground
        setup()
    }
    
    var lessonViewModel: LessonViewModel! {
        didSet {
            guard let url = URL(string: lessonViewModel.imageUrl ?? "") else { return }
            let data = try? Data(contentsOf: url)
            lessonImage.image = UIImage(data: data!)
            subjectLabel.text = lessonViewModel.subjectName
            timeLabel.text = "\(lessonViewModel.getDate())"
            lessonStateLabel.text = "• \(lessonViewModel.status ?? "")".uppercased()
            lessonTutorLabel.text = "\(lessonViewModel.tutorFirstName ?? "") \(lessonViewModel.getLastName())"
            lessonStateLabel.backgroundColor = lessonViewModel.status  == "upcoming" ? .systemGray : lessonViewModel.status  == "live" ? .systemRed : .systemOrange
            widthConstant?.constant = lessonViewModel.status  == "upcoming" ? 110 : lessonViewModel.status  == "live" ? 70 : 90
        }
    }
    
    func configureCell(forLessons lesson: LessonsMainViewModel) {
        if  !(lesson.imageUrl!.isEmpty) {
            self.lessonImage.af.setImage(
                withURL: URL(string: (lesson.imageUrl ?? ""))!,
                placeholderImage: Icons.Common.checkedBig,
                imageTransition: .crossDissolve(0.2)
        )}
        subjectLabel.text = lesson.subjectName
        timeLabel.text = "\(lesson.date ?? "")"
        lessonStateLabel.text = "• \(lesson.status ?? "")".uppercased()
        lessonStateLabel.backgroundColor = lesson.status  == "upcoming" ? .systemGray : lesson.status  == "live" ? .systemRed : .systemOrange
        widthConstant?.constant = lesson.status  == "upcoming" ? 110 : lesson.status  == "live" ? 70 : 90
        lessonTutorLabel.text = "\(lesson.tutorFullName ?? "")"
        lessonTitleLabel.text = lesson.topic
    }

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        addSubview(lessonImage)
        lessonImage.apply {
            $0.backgroundColor = .appGold
            $0.roundCorners()
            $0.contentMode = .scaleAspectFill
            $0.leadingAnchor.equal(to: leadingAnchor, constant: 8).activate()
            $0.centerYAnchor.equal(to: centerYAnchor, constant: 0).activate()
            $0.widthAnchor.equalTo(constant: self.frame.height + 50).activate()
            $0.heightAnchor.equalTo(constant: self.frame.height).activate()
        }
        
        lessonImage.addSubview(lessonStateLabel)
        lessonStateLabel.apply {
            $0.backgroundColor = .systemGray
            $0.text = "Upcoming"
            $0.textAlignment = .center
            $0.font = UIFont.custom(ofSize: Constants.FontSize.body, font: UIFont.Roboto.medium)
            $0.lineHeight = Constants.NameLabel.lineHeight
            $0.textColor = UIColor.appTextWhite
            $0.numberOfLines = Constants.NameLabel.numberOfLines
            $0.roundCorners()
            
            $0.bottomAnchor.equal(to: lessonImage.bottomAnchor, constant: -8).activate()
            $0.leadingAnchor.equal(to: lessonImage.leadingAnchor, constant: 8).activate()
            widthConstant = $0.widthAnchor.equalTo(constant: 90).activate()
            $0.heightAnchor.equalTo(constant: 25).activate()
        }
        
        subjectLabel.apply {
            $0.text = "Physics"
            $0.font = UIFont.custom(ofSize: Constants.FontSize.subtitle, font: UIFont.Roboto.regular)
            $0.lineHeight = Constants.NameLabel.lineHeight
            $0.textColor = .systemBlue
            $0.numberOfLines = Constants.NameLabel.numberOfLines
        }
        
        self.addSubview(subjectLabel)
        
        subjectLabel.apply {
            $0.topAnchor.equal(to: lessonImage.topAnchor, constant: 4).activate()
            $0.leadingAnchor.equal(to: lessonImage.trailingAnchor, constant: 8).activate()
            $0.trailingAnchor.equal(to: trailingAnchor, constant: -8).activate()
            $0.heightAnchor.equalTo(constant: 30).activate()
        }
        
        lessonTitleLabel.apply {
            $0.text = "Materials - Metals & Non Metals"
            $0.font = UIFont.custom(ofSize: Constants.FontSize.subtitle, font: UIFont.Roboto.bold)
            $0.lineHeight = Constants.NameLabel.lineHeight
            $0.textColor = UIColor.appTextMediumBright
            $0.numberOfLines = Constants.NameLabel.numberOfLines
        }
        
        self.addSubview(lessonTitleLabel)
        
        lessonTitleLabel.apply {
            $0.topAnchor.equal(to: subjectLabel.bottomAnchor, constant: 4).activate()
            $0.leadingAnchor.equal(to: subjectLabel.leadingAnchor, constant: 0).activate()
            $0.trailingAnchor.equal(to: subjectLabel.trailingAnchor, constant: 0).activate()
            $0.heightAnchor.equalTo(constant: 60).activate()
        }
        
        timeImage.apply {
            $0.image = Icons.Common.checkedBig
            $0.clipsToBounds = true
            $0.layer.cornerRadius = Constants.ClockImageView.height / 2
        }
        
        self.addSubview(timeImage)
        
        timeImage.apply {
            $0.topAnchor.equal(to: lessonTitleLabel.bottomAnchor, constant: 4).activate()
            $0.leadingAnchor.equal(to: lessonTitleLabel.leadingAnchor, constant: 0).activate()
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
        
        self.addSubview(timeLabel)
        
        timeLabel.apply {
            $0.topAnchor.equal(to: timeImage.topAnchor, constant: -6).activate()
            $0.leadingAnchor.equal(to: timeImage.trailingAnchor, constant: 8).activate()
            $0.trailingAnchor.equal(to: subjectLabel.trailingAnchor, constant: -16).activate()
            $0.bottomAnchor.equal(to: timeImage.bottomAnchor, constant: 0).activate()
        }
        
        userImage.apply {
            $0.image = Icons.Common.user
            $0.clipsToBounds = true
            $0.layer.cornerRadius = Constants.ClockImageView.height / 2
        }
        
        self.addSubview(userImage)
        
        userImage.apply {
            $0.topAnchor.equal(to: timeImage.bottomAnchor, constant: 4).activate()
            $0.leadingAnchor.equal(to: timeImage.leadingAnchor, constant: 0).activate()
            $0.widthAnchor.equalTo(constant: 20).activate()
            $0.heightAnchor.equalTo(constant: 20).activate()
        }
        
        lessonTutorLabel.apply {
            $0.text = "Gabriella Adeboye"
            $0.font = UIFont.custom(ofSize: Constants.FontSize.small, font: UIFont.Roboto.regular)
            $0.lineHeight = Constants.NameLabel.lineHeight
            $0.textColor = UIColor.appTextMediumBright
            $0.numberOfLines = Constants.NameLabel.numberOfLines
        }
        
        self.addSubview(lessonTutorLabel)
        
        lessonTutorLabel.apply {
            $0.topAnchor.equal(to: userImage.topAnchor, constant: -6).activate()
            $0.leadingAnchor.equal(to: userImage.trailingAnchor, constant: 8).activate()
            $0.trailingAnchor.equal(to: subjectLabel.trailingAnchor, constant: -16).activate()
            $0.bottomAnchor.equal(to: userImage.bottomAnchor, constant: 0).activate()
        }
    }
}
