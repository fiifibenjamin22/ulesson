//
//  UINavigationControllerExtension.swift
//  Ulessons
//
//  Created by Benjamin Acquah on 9/29/21.
//

import Foundation
import UIKit

extension UINavigationController {
    
    func setShadowBarEnabled(_ isShadowEnabled: Bool) {
        self.navigationBar.apply {
            $0.shadowImage = isShadowEnabled ? UIImage() : nil
            if isShadowEnabled {
                $0.addShadow(withOpacity: 0.1, radius: 10)
            } else {
                $0.removeShadow()
            }
        }
    }
    
    func applyProfileItemAppearance(withTitle title: String) {
        self.topViewController?.navigationItem.title = title
        self.setNavigationBarHidden(false, animated: true)
        self.navigationBar.tintColor = .appGreyLight
        self.setShadowBarEnabled(false)
        self.removeTransparentTheme()
    }
    
    func setNavigationBarBorderColor(_ color: UIColor = UIColor.appBackground) {
        self.navigationBar.shadowImage = color.as1ptImage()
    }
    
    func setTitleColor(_ color: UIColor) {
        guard let self = self as? AppNavigationController else {
            fatalError("Navigation controller should be of type AppNavigationController" )
        }
        self.navigationBar.titleTextAttributes = self.titleTextAttributes(withColor: color)
    }
    
    func applyTransparentTheme(withColor color: UIColor) {
        setTitleColor(color)
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage = UIImage()
        navigationBar.tintColor = color
        navigationBar.backgroundColor = .clear
        navigationBar.isTranslucent = true
    }
    
    func removeTransparentTheme() {
        setTitleColor(.appText)
        navigationBar.tintColor = .appGreyLight
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage = UIImage()
        navigationBar.isTranslucent = false
        navigationBar.backgroundColor = .white
        navigationBar.barTintColor = .white
    }
    
    func applyWhiteTheme() {
        navigationBar.tintColor = UIColor.lightBackArrowColor
        navigationBar.barStyle = .default
        navigationBar.isTranslucent = false
        navigationBar.backgroundColor = .white
        navigationBar.titleTextAttributes =
            [NSAttributedString.Key.foregroundColor: UIColor.black,
             NSAttributedString.Key.font: UIFont.custom(ofSize: Constants.FontSize.tiny, font: UIFont.Roboto.bold)]
    }
    
}

fileprivate extension UIColor {
    
    /// Converts this `UIColor` instance to a 1x1 `UIImage` instance and returns it.
    ///
    /// - Returns: `self` as a 1x1 `UIImage`.
    func as1ptImage() -> UIImage {
        UIGraphicsBeginImageContext(CGSize(width: 1, height: 1))
        setFill()
        UIGraphicsGetCurrentContext()?.fill(CGRect(x: 0, y: 0, width: 1, height: 1))
        let image = UIGraphicsGetImageFromCurrentImageContext() ?? UIImage()
        UIGraphicsEndImageContext()
        return image
    }
    
}
