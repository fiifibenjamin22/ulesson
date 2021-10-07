//
//  RightIconButton.swift
//  Ulessons
//
//  Created by Benjamin Acquah on 10/5/21.
//

import UIKit

class RightIconButton: UIButton {
    
    private let buttonPadding: CGFloat = Constants.Margin.standard
    
    private let spacing: CGFloat = 4
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initialize() {
        manualLayoutable()
        applyTouchAnimation()
        
        contentHorizontalAlignment = .center
        titleLabel?.font = UIFont.custom(ofSize: Constants.FontSize.body, font: UIFont.Roboto.regular)
        
        var configuration = RightIconButton.Configuration.filled()
        configuration.title = "Title"
        configuration.image = Icons.Common.dropdown
        configuration.titlePadding = 10
        configuration.imagePadding = 10
        configuration.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        

        
//        contentEdgeInsets = UIEdgeInsets(padding: buttonPadding).insetBy(dx: spacing, dy: 0)
//        titleEdgeInsets = UIEdgeInsets(top: 0, left: spacing, bottom: 0, right: -spacing)
//        imageEdgeInsets = UIEdgeInsets(top: 0, left: -spacing, bottom: 0, right: spacing)
    }
}

