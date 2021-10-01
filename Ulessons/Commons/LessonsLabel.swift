//
//  LessonsLabel.swift
//  Ulessons
//
//  Created by Benjamin Acquah on 9/30/21.
//

import Foundation
import UIKit

class LessonsLabel: UILabel {

    var insets = UIEdgeInsets.zero
    var letterSpacing: CGFloat = 0
    
    var lineHeight: CGFloat? {
        didSet {
            updateTextAttributes()
        }
    }
    
    override var text: String? {
        didSet {
             updateTextAttributes()
        }
    }
    
    override var attributedText: NSAttributedString? {
        didSet {
            updateTextAttributes()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: insets))
    }
    
    override var intrinsicContentSize: CGSize {
        var contentSize = super.intrinsicContentSize
        contentSize.height += insets.top + insets.bottom
        contentSize.width += insets.left + insets.right
        return contentSize
    }
    
    private func initialize() {}
    
    func setHtmlText(_ text: String) {
        self.attributedText = text.attributedFromHtml(withColor: self.textColor, font: self.font)
    }
    
    private func updateTextAttributes() {
        guard let lineHeight = lineHeight else {
            updateTextAttributesWithoutLine()
            return
        }
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.minimumLineHeight = lineHeight
        paragraphStyle.lineBreakMode = .byTruncatingTail
        paragraphStyle.alignment = self.textAlignment
        if let attributedText = self.attributedText {
            let mutable = NSMutableAttributedString(attributedString: attributedText)
            mutable.addAttributes([NSAttributedString.Key.paragraphStyle: paragraphStyle], range: NSRange(location: 0, length: mutable.length))
            super.attributedText = mutable
        } else {
            super.attributedText = NSAttributedString(
                string: self.text ?? "",
                attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle,
                             NSAttributedString.Key.kern: letterSpacing])
        }
    }
    
    private func updateTextAttributesWithoutLine() {
        guard let current = self.attributedText else {
            super.attributedText = NSAttributedString(
                string: self.text ?? "",
                attributes: [.kern: letterSpacing])
            return
        }
        super.attributedText = NSMutableAttributedString(attributedString: current).apply {
            $0.addAttribute(.kern, value: letterSpacing, range: NSRange(location: 0, length: current.length))
        }
    }
}
