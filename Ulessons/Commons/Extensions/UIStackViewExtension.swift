//
//  UIStackViewExtension.swift
//  Ulessons
//
//  Created by Benjamin Acquah on 10/5/21.
//

import UIKit

extension UIStackView {

    convenience init(
        axis: NSLayoutConstraint.Axis = .vertical,
        with views: [UIView] = [],
        spacing: CGFloat = 0,
        alignment: UIStackView.Alignment = .fill,
        distribution: UIStackView.Distribution = .fill) {
        
        self.init(arrangedSubviews: views)
        self.axis = axis
        self.spacing = spacing
        self.alignment = alignment
        self.distribution = distribution
        self.manualLayoutable()
    }
    
    func addDefaultSeperator(withColor color: UIColor = UIColor.lightBackgroundSeperator, size: CGFloat = 1, alpha: CGFloat = 1) {
        let seperator = UIView().apply {
            (axis == .vertical ? $0.heightAnchor : $0.widthAnchor).equalTo(constant: size)
            $0.backgroundColor = color.withAlphaComponent(alpha)
        }
        addArrangedSubview(seperator)
    }
    
    func addSeperatedViews(_ views: [UIView], withColor color: UIColor = UIColor.lightBackgroundSeperator) {
        views.forEach {
            addArrangedSubview($0)
            addDefaultSeperator(withColor: color)
        }
    }

    func addArrangedSubviews(_ views: [UIView]) {
        views.forEach { addArrangedSubview($0) }
    }
    
    func removeLastSubview() {
        guard let last = arrangedSubviews.last else { return }
        removeArrangedSubview(last)
    }

    func removeArrangedSubviews() {
        let removedSubviews = arrangedSubviews.reduce([]) { (allSubviews, subview) -> [UIView] in
            self.removeArrangedSubview(subview)
            return allSubviews + [subview]
        }

        // Deactivate all constraints
        NSLayoutConstraint.deactivate(removedSubviews.flatMap({ $0.constraints }))

        // Remove the views from self
        removedSubviews.forEach({ $0.removeFromSuperview() })
    }

}
