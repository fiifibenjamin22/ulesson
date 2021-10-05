//
//  UILabelExtension.swift
//  Ulessons
//
//  Created by Benjamin Acquah on 10/5/21.
//

import UIKit

extension UILabel {
    
    static func styled(
        textColor: UIColor = .appText,
        withFont font: UIFont = UIFont.app(ofSize: Constants.FontSize.body, weight: .regular),
        alignment: NSTextAlignment = .center,
        numberOfLines: Int = 0) -> UILabel {

        let label = LessonsLabel()
        label.textColor = textColor
        label.font = font
        label.textAlignment = alignment
        label.numberOfLines = numberOfLines
        label.setContentCompressionResistancePriority(UILayoutPriority(rawValue: 998), for: .vertical)
        label.setContentCompressionResistancePriority(UILayoutPriority(rawValue: 998), for: .horizontal)
        label.manualLayoutable()

        return label
    }
    
    static func withMainMessageStyle() -> UILabel {
        return styled(
            textColor: UIColor.appTextBright,
            withFont: UIFont.custom(ofSize: Constants.FontSize.subtitle, font: UIFont.Roboto.medium),
            alignment: .center,
            numberOfLines: 0)
    }

}

extension LessonsLabel {
    
    func withText(_ text: String?) -> LessonsLabel {
        return self.apply {
            $0.text = text
        }
    }
    
    static func styled(
        withTextColor textColor: UIColor = .appText,
        withFont font: UIFont = UIFont.app(ofSize: Constants.FontSize.body, weight: .regular),
        alignment: NSTextAlignment = .center,
        numberOfLines: Int = 0,
        letterSpacing: CGFloat = 0) -> LessonsLabel {
        let parlorLabel = (styled(textColor: textColor, withFont: font, alignment: alignment, numberOfLines: numberOfLines) as? LessonsLabel) ?? LessonsLabel()
        parlorLabel.letterSpacing = letterSpacing
        return parlorLabel
    }
    
    static func withSubMessageStyle() -> LessonsLabel {
        return LessonsLabel().apply {
            $0.numberOfLines = 0
            $0.textColor = UIColor.textFieldUnderline
            $0.font = UIFont.custom(ofSize: Constants.FontSize.tiny, font: UIFont.Roboto.regular)
            $0.textAlignment = .center
            $0.lineHeight = 18
        }
    }
    
    static func withSectionHeaderLabelStyle(
        insets: UIEdgeInsets = UIEdgeInsets(top: 25, left: 16, bottom: 16, right: 0)
    ) -> LessonsLabel {
        return LessonsLabel.styled(
            withTextColor: .appGrey,
            withFont: UIFont.custom(ofSize: Constants.FontSize.tiny, font: UIFont.Helvetica.regular),
            alignment: .left,
            numberOfLines: 1
        ).apply {
            $0.insets = insets
        }
    }
}
