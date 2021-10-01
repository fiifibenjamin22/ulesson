//
//  Constants.swift
//  Ulessons
//
//  Created by Benjamin Acquah on 9/28/21.
//

import UIKit

enum Constants {
    
    /// - Tag: DefaultAppCornerRadius
    static let cornerRadius: CGFloat = 8.0
    static let animationDuration: TimeInterval = 0.2
    static let transitionAnimationDuration: TimeInterval = 0.4
    static let navigationBarHeight: CGFloat = 44
    static let separatorSize: CGFloat = 1
    static let defaultPagingCap: Double = 1
    static let buttonDefaultWidth: CGFloat = 196
    static let buttonHeight: CGFloat = 50
    static let bigButtonHeight: CGFloat = 55
    static let extraBigButtonHeight: CGFloat = 72
    static let horizontalMarginBig: CGFloat = 35
    static let horizontalMargin: CGFloat = 25
    static let roundedIconSize: CGFloat = 100
    static let lineHeightBig: CGFloat = 24
    static let standardButtonHeight: CGFloat = 40

    enum Margin {
        static let tiny: CGFloat = 6
        static let small: CGFloat = 10
        static let standard: CGFloat = 16
        static let big: CGFloat = 20
        static let large: CGFloat = 24
    }
    
    enum FontSize {
        static let xxxTiny: CGFloat = 9
        static let xxTiny: CGFloat = 10
        static let xTiny: CGFloat = 11
        static let tiny: CGFloat = 12
        static let small: CGFloat = 13
        static let subbody: CGFloat = 14
        static let body: CGFloat = 15
        static let hintSize: CGFloat = 16
        static let subheading: CGFloat = 17
        static let heading: CGFloat = 18
        static let subtitle: CGFloat = 20
        static let mainMessage: CGFloat = 22
        static let smallTitle: CGFloat = 24
        static let title: CGFloat = 25
        static let largeTitle: CGFloat = 32
        static let largeDate: CGFloat = 35
    }
    
    enum LetterSpacing {
        static let none: CGFloat = 0
        static let small: CGFloat = 1.11
        static let medium: CGFloat = 2
    }
    
    enum NameLabel {
        static let leftMargin: CGFloat = 13
        static let bottomMargin: CGFloat = -20
        static let centerYMargin: CGFloat = -8
        static let lineHeight: CGFloat = 22
        static let numberOfLines: Int = 2
    }
    
    enum ClockImageView {
        static let height: CGFloat = 20
        static let insets: UIEdgeInsets = UIEdgeInsets(top: 20, left: 16, bottom: 40, right: 0)
    }
    
    enum ButtonView {
        static let width: CGFloat = 60
    }
}

