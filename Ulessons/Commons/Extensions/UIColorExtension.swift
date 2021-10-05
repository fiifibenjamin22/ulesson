//
//  UIColorExtension.swift
//  Ulessons
//
//  Created by Benjamin Acquah on 9/28/21.
//

import UIKit

extension UIColor {

    static let appPrimary = UIColor.white

    static let appTintColor = UIColor.white

    static let appBlack = UIColor.init(red: 46 / 255, green: 46 / 255, blue: 46 / 255, alpha: 1)

    static let appBackground = UIColor(red: 247 / 255, green: 247 / 255, blue: 247 / 255, alpha: 1)

    static let appSeparator = UIColor(red: 228 / 255, green: 228 / 255, blue: 228 / 255, alpha: 1)

    static let appSemiTransparentSeparator = UIColor(red: 228 / 255, green: 228 / 255, blue: 228 / 255, alpha: 0.5)

    static let appText = UIColor.init(red: 16 / 255, green: 16 / 255, blue: 16 / 255, alpha: 1)

    static let appTextSemiLight = UIColor.init(red: 98 / 255, green: 98 / 255, blue: 98 / 255, alpha: 1)

    static let appTextBright = UIColor.init(red: 46 / 255, green: 46 / 255, blue: 46 / 255, alpha: 1)

    static let appTextMediumBright = UIColor.init(red: 60 / 255, green: 60 / 255, blue: 60 / 255, alpha: 1)

    static let appTextLight = UIColor.init(red: 155 / 255, green: 155 / 255, blue: 155 / 255, alpha: 1)
    
    static let appTextGold = UIColor.init(red: 189 / 255, green: 159 / 255, blue: 87 / 255, alpha: 1)

    static let appGrey = UIColor.init(red: 44 / 255, green: 44 / 255, blue: 44 / 255, alpha: 1)

    static let appGreyLight = UIColor.init(red: 136 / 255, green: 136 / 255, blue: 136 / 255, alpha: 1)

    static let appGold = UIColor.init(red: 189 / 255, green: 159 / 255, blue: 87 / 255, alpha: 1)

    static let appTextWhite = UIColor.init(red: 247 / 255, green: 247 / 255, blue: 247 / 255, alpha: 1)

    static let textFieldUnderline = UIColor.init(red: 98 / 255, green: 98 / 255, blue: 98 / 255, alpha: 1)

    static let eventTime = UIColor.init(red: 204 / 255, green: 204 / 255, blue: 204 / 255, alpha: 1)

    static let rsvpBorder = UIColor.init(red: 60 / 255, green: 60 / 255, blue: 60 / 255, alpha: 1)

    static let emptyDataRsvpBorder = UIColor(red: 228 / 255, green: 228 / 255, blue: 228 / 255, alpha: 1)

    static let appGreyLightest = UIColor(red: 228 / 255, green: 228 / 255, blue: 228 / 255, alpha: 1)

    static let textGreen = UIColor.init(red: 2 / 255, green: 192 / 255, blue: 149 / 255, alpha: 1)

    static let backgroundGreen = UIColor.init(red: 0 / 255, green: 217 / 255, blue: 168 / 255, alpha: 1)

    static let closeTintColor = UIColor.init(red: 136 / 255, green: 136 / 255, blue: 136 / 255, alpha: 1)
    
    static let textVeryLight = UIColor.init(red: 242 / 255, green: 242 / 255, blue: 242 / 255, alpha: 1)
    
    static let lightBackgroundSeperator = UIColor.init(red: 216 / 255, green: 216 / 255, blue: 216 / 255, alpha: 1)
    
    static let lightBackArrowColor = UIColor.init(red: 125 / 255, green: 125 / 255, blue: 125 / 255, alpha: 1)

    static let appGreen = UIColor.init(red: 0 / 255, green: 217 / 255, blue: 168 / 255, alpha: 1)
    
    static let appGreenDark = UIColor.init(red: 0 / 255, green: 193 / 255, blue: 150 / 255, alpha: 1)

    static let appYellow = UIColor.init(red: 254 / 255, green: 202 / 255, blue: 41 / 255, alpha: 1)
    
    static let backgroundMediumDark = UIColor.init(red: 31 / 255, green: 31 / 255, blue: 31 / 255, alpha: 1)
    
    static let darkBackground = UIColor.init(red: 10 / 255, green: 10 / 255, blue: 10 / 255, alpha: 1)

    static let brownGrey = UIColor.init(red: 118 / 255, green: 117 / 255, blue: 115 / 255, alpha: 1)

    static let lightSeparator = UIColor.init(red: 231 / 255, green: 231 / 255, blue: 231 / 255, alpha: 1)

    static let shareActivationNavigationUnderline = UIColor.init(red: 246 / 255, green: 246 / 255, blue: 246 / 255, alpha: 1)

    enum LocationCell {
        static let cellDate = UIColor.init(red: 149 / 255, green: 149 / 255, blue: 149 / 255, alpha: 1)
        static let cellTime = UIColor.init(red: 206 / 255, green: 206 / 255, blue: 206 / 255, alpha: 1)
        static let cellBack = UIColor.init(red: 34 / 255, green: 35 / 255, blue: 36 / 255, alpha: 1)
    }
    
    enum ActivationUpcomingCell {
        static let cellPlace = UIColor.init(red: 206 / 255, green: 206 / 255, blue: 206 / 255, alpha: 1)
    }

}

extension UIColor {
    
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt32()
        Scanner(string: hex).scanHexInt32(&int)
        let alpha, red, green, blue: UInt32
        switch hex.count {
        case 3: // RGB (12-bit)
            (alpha, red, green, blue) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (alpha, red, green, blue) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (alpha, red, green, blue) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (alpha, red, green, blue) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(red) / 255, green: CGFloat(green) / 255, blue: CGFloat(blue) / 255, alpha: CGFloat(alpha) / 255)
    }

    func toHexString() -> String {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        let rgb: Int = (Int)(red * 255) << 16 | (Int)(green * 255) << 8 | (Int)(blue * 255) << 0
        return String(format: "#%06x", rgb)
    }

}
