//
//  UIFontExtension.swift
//  Ulessons
//
//  Created by Benjamin Acquah on 9/28/21.
//

import UIKit

extension UIFont {

    static func app(ofSize size: CGFloat, weight: UIFont.Weight) -> UIFont {
        return UIFont.systemFont(ofSize: size, weight: weight)
    }

    func withTraits(traits: UIFontDescriptor.SymbolicTraits...) -> UIFont? {
        guard let descriptorL = self.fontDescriptor.withSymbolicTraits(UIFontDescriptor.SymbolicTraits(traits)) else {
            return nil
        }
        return UIFont(descriptor: descriptorL, size: 0)
    }
    
    func expectedLinesCount(forUILabelWithWidth width: CGFloat, text: String) -> Int {
        let maxSize = CGSize(width: width, height: CGFloat(Float.infinity))
        let charSize = self.lineHeight
        let nsText = text as NSString
        let textSize = nsText.boundingRect(with: maxSize, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: self], context: nil)
        let linesRoundedUp = Int(ceil(textSize.height / charSize))
        return linesRoundedUp
    }

}

// MARK: - Custom fonts
extension UIFont {
    
    enum Calibre: String, FontNameConvertible {
        case light = "Calibre-Light"
    }
    
    enum Roboto: String, FontNameConvertible {
        case light = "Roboto-Light"
        case regular = "Roboto-Regular"
        case medium = "Roboto-Medium"
        case bold = "Roboto-Bold"
    }

    enum Helvetica: String, FontNameConvertible {
        case light = "Helvetica-Light"
        case regular = "Helvetica"
        case medium = "Helvetica-Medium"
        case bold = "Helvetica-Bold"
    }

    enum Editor: String, FontNameConvertible {
        case medium = "Editor-Medium"
        case bold = "Editor-Bold"
        case extraBold = "Editor-Extrabold"
    }
    
    enum Dalmatins: String, FontNameConvertible {
        case regular = "Dalmatins"
    }

    static func custom(ofSize size: CGFloat, font: FontNameConvertible) -> UIFont {
        do {
            if let font = UIFont(name: font.name, size: size) {
                return font
            } else {
                throw AppError()
            }
        } catch {
            #if DEBUG
                fatalError("UIFont fatalError: Font \(font.name) is not accessible")
            #endif
        }
        //return UIFont.app(ofSize: size, weight: .regular)
    }
}

protocol FontNameConvertible {
    var name: String { get }
}

extension FontNameConvertible where Self: RawRepresentable {
    
    var name: String {
        return rawValue as? String ?? ""
    }
}
