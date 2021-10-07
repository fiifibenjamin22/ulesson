//
//  UIEdgeInsets.swift
//  Ulessons
//
//  Created by Benjamin Acquah on 9/28/21.
//

import UIKit

// MARK: Convinient inits
extension UIEdgeInsets {
    init(padding: CGFloat) {
        self.init(top: padding, left: padding, bottom: padding, right: padding)
    }

    init(top: CGFloat = 0.0, bottom: CGFloat = 0.0, left: CGFloat = 0.0, right: CGFloat = 0.0) {
        self.init(top: top, left: left, bottom: bottom, right: right)
    }

    init(side: CGFloat = 0.0) {
        self.init(top: side, left: side, bottom: side, right: side)
    }

    init(top: CGFloat = 0.0, bottom: CGFloat = 0.0, horizontal: CGFloat = 0.0) {
        self.init(top: top, left: horizontal, bottom: bottom, right: horizontal)
    }

    init(vertical: CGFloat = 0.0, horizontal: CGFloat = 0.0) {
        self.init(top: vertical, bottom: vertical, horizontal: horizontal)
    }
}

// MARK: Functions
extension UIEdgeInsets {
    
    func insetBy(dx: CGFloat, dy: CGFloat) -> UIEdgeInsets {
        return UIEdgeInsets(
            top: top + dy,
            left: left + dx,
            bottom: bottom + dy,
            right: right + dx)
    }
    
}

// MARK: Static methods
extension UIEdgeInsets {
    
    static func margins(
        top: CGFloat = 0,
        left: CGFloat = 0,
        bottom: CGFloat = 0,
        right: CGFloat = 0
    ) -> UIEdgeInsets {
        return UIEdgeInsets(top: top, left: left, bottom: bottom, right: right)
    }
    
}
