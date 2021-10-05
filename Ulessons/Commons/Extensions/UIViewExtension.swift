//
//  UIViewExtension.swift
//  Ulessons
//
//  Created by Benjamin Acquah on 9/28/21.
//

import UIKit

// MARK: - Border
extension UIView {
    
    func addLightBorder() {
        self.layer.borderColor = UIColor.textVeryLight.cgColor
        self.layer.borderWidth = 1
    }
    
    func addDarkBorder() {
        self.layer.borderColor = UIColor.backgroundMediumDark.cgColor
        self.layer.borderWidth = 1
    }
    
}

// MARK: - Round corners
extension UIView {

    /// Adds corners to view.
    ///
    /// - Parameter radius: Radius of corners. Default value is declared in [Constants](x-source-tag://DefaultAppCornerRadius)
    /// - Parameter corners: Specify which corners should be rounded. All corenrs are rounded by default
    func roundCorners(
        with radius: CGFloat = Constants.cornerRadius,
        and corners: CACornerMask = [
                .layerMinXMinYCorner,
                .layerMaxXMinYCorner,
                .layerMinXMaxYCorner,
                .layerMaxXMaxYCorner
        ]) {
        layer.cornerRadius = radius
        layer.masksToBounds = true
        layer.maskedCorners = corners
    }
    
    func addSubviews(_ subviews: [UIView]) {
        subviews.forEach { addSubview($0) }
    }
    
}

// MARK: - Autolayout
extension UIView {
    
    func constraintByCenteringVerticallyBeetween(_ topView: UIView, and bottomView: UIView, margin: CGFloat = 0) {
        constraintByCenteringVerticallyBeetween(topView.bottomAnchor, and: bottomView.topAnchor, margin: margin)
    }
    
    func constraintByCenteringVerticallyBeetween(_ topAnchor: NSLayoutYAxisAnchor, and bottomAnchor: NSLayoutYAxisAnchor, margin: CGFloat = 0) {
        guard let parentView = self.superview else { fatalError("View does not have a parent") }
        let helpGuide = UILayoutGuide()
        parentView.addLayoutGuide(helpGuide)
        helpGuide.topAnchor.equal(to: topAnchor)
        helpGuide.bottomAnchor.equal(to: bottomAnchor)
        self.centerYAnchor.equal(to: helpGuide.centerYAnchor)
        self.topAnchor.greaterThanOrEqual(to: topAnchor, constant: margin)
        self.bottomAnchor.lessThanOrEqual(to: bottomAnchor, constant: -margin)
    }

    @discardableResult
    func manualLayoutable() -> Self {
        translatesAutoresizingMaskIntoConstraints = false
        return self
    }
    
    @discardableResult
    func isManualLayoutEnabled(_ isOn: Bool) -> Self {
        return self.apply {
            $0.translatesAutoresizingMaskIntoConstraints = !isOn
        }
    }

    /// Anchor of the view
    enum Anchor: CaseIterable {
        case top
        case trailing
        case bottom
        case leading
    }

    /// Constrains view to edges of its parent
    ///
    /// - Parameter padding: view padding
    /// - Parameter anchors: eges of view which need to be constrained.
    ///     All anchors included by default
    func edgesToParent(anchors: [Anchor] = Anchor.allCases, padding: CGFloat) {
        edgesToParent(
            anchors: anchors,
            insets: UIEdgeInsets(
                top: padding,
                left: padding,
                bottom: padding,
                right: padding)
        )
    }

    /// Constrains view to edges of its parent
    ///
    /// - Parameter insets: edge insets
    /// - Parameter anchors: eges of view which need to be constrained.
    ///     All anchors included by default
    func edgesToParent(anchors: [Anchor] = Anchor.allCases, insets: UIEdgeInsets = .margins()) {
        guard let parent = superview else {
            fatalError("View doesn't have superview")
        }

        if anchors.contains(.top) {
            self.topAnchor.equal(to: parent.topAnchor, constant: insets.top).activate()
        }

        if anchors.contains(.bottom) {
            self.bottomAnchor.equal(to: parent.bottomAnchor, constant: -insets.bottom).activate()
        }

        if anchors.contains(.leading) {
            self.leadingAnchor.equal(to: parent.leadingAnchor, constant: insets.left).activate()
        }

        if anchors.contains(.trailing) {
            self.trailingAnchor.equal(to: parent.trailingAnchor, constant: -insets.right).activate()
        }
    }

    func edgesToParentSafeArea(anchors: [Anchor] = Anchor.allCases, insets: UIEdgeInsets = .zero) {
        guard let parent = superview else {
            fatalError("View doesn't have superview")
        }

        if anchors.contains(.top) {
            self.topAnchor.equal(to: parent.safeAreaLayoutGuide.topAnchor, constant: insets.top).activate()
        }

        if anchors.contains(.bottom) {
            self.bottomAnchor.equal(to: parent.safeAreaLayoutGuide.bottomAnchor, constant: -insets.bottom).activate()
        }

        if anchors.contains(.leading) {
            self.leadingAnchor.equal(to: parent.safeAreaLayoutGuide.leadingAnchor, constant: insets.left).activate()
        }

        if anchors.contains(.trailing) {
            self.trailingAnchor.equal(to: parent.safeAreaLayoutGuide.trailingAnchor, constant: -insets.right).activate()
        }
    }

    /// Constrains a given subview to all 4 sides
    /// of its containing view with a constant of given value. Default value is 0.
    ///
    /// - Parameter subView: view to constrain to its container
    /// - Parameter edges: top, left, right and bottom view margins
    func edgeConstraint(subView: UIView, insets: UIEdgeInsets = UIEdgeInsets.margins()) {
        subView.translatesAutoresizingMaskIntoConstraints = false

        subView.topAnchor.equal(to: self.topAnchor, constant: insets.top).activate()
        subView.bottomAnchor.equal(to: self.bottomAnchor, constant: insets.bottom).activate()
        subView.leadingAnchor.equal(to: self.leadingAnchor, constant: insets.left).activate()
        subView.trailingAnchor.equal(to: self.trailingAnchor, constant: insets.right).activate()
    }

    func edges(equalTo parent: UIView, insets: UIEdgeInsets = UIEdgeInsets.margins()) {
        parent.edgeConstraint(
            subView: self,
            insets: UIEdgeInsets.margins(
                top: insets.top,
                left: insets.left,
                bottom: -insets.bottom,
                right: -insets.right
            )
        )
    }

    func edges(equalTo parent: UIView, constant: CGFloat) {
        edges(
            equalTo: parent,
            insets: UIEdgeInsets.margins(
                top: constant,
                left: constant,
                bottom: -constant,
                right: -constant
            )
        )
    }
}

// MARK: - Shadow
extension UIView {

    static var defaultShadowOpacity: Float { return 0.2 }

    var hasShadow: Bool {
        return self.layer.shadowColor == UIColor.black.cgColor && self.layer.shadowRadius > 0
    }

    func addShadow(withOpacity opaticy: Float = 0.3, radius: CGFloat = Constants.cornerRadius, shadowOffset: CGSize = .zero) {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        
        layer.shadowOffset = shadowOffset
        layer.shadowRadius = radius
        layer.shadowOpacity = opaticy
    }

    func removeShadow() {
        self.addShadow(withOpacity: 0, radius: 0)
    }

    func setupTapGestureRecognizer(target: Any?, action: Selector?) {
        isUserInteractionEnabled = true
        let recognizer = UITapGestureRecognizer(target: target, action: action)
        self.addGestureRecognizer(recognizer)
    }

    func show(animated: Bool = true, animationDuration: TimeInterval = Constants.animationDuration) {
        UIView.animate(withDuration: animated ? animationDuration : 0, animations: { [weak self] in
            self?.isHidden = false
            self?.superview?.layoutIfNeeded()
        }) { [weak self] _ in
            self?.isHidden = false
        }
    }

    func hide(animated: Bool = true, animationDuration: TimeInterval = Constants.animationDuration) {
        UIView.animate(withDuration: animated ? animationDuration : 0) { [weak self] in
            self?.isHidden = true
        }
    }
}

// MARK: - Default Modal Animation
extension UIView {
    
    func animateEntrance() {
        let maskView = createMask(isInitialAnimation: true)
        alpha = 1
        mask = maskView
        UIView.animate(withDuration: 0.5, animations: { [weak self, weak maskView] in
            guard let strongSelf = self else { return }
            maskView?.frame = CGRect(x: 0, y: 0, width: strongSelf.frame.width, height: strongSelf.frame.height)
        }, completion: { [weak self] _ in
            self?.mask = nil
        })
    }
    
    func animateDismiss(completion: @escaping Function = {}) {
        let maskView = createMask(isInitialAnimation: false)
        mask = maskView
        UIView.animate(withDuration: 0.5, animations: { [weak self, weak maskView] in
            guard let strongSelf = self else { return }
            maskView?.frame = CGRect(x: 0, y: strongSelf.frame.height, width: strongSelf.frame.width, height: 0)
        }, completion: { _ in
            completion()
        })
    }
    
    private func createMask(isInitialAnimation: Bool) -> UIView {
        return UIView().apply {
            let currentFrame = frame
            $0.backgroundColor = .white
            $0.frame = CGRect(x: 0, y: 0, width: currentFrame.width, height: isInitialAnimation ? 0 : currentFrame.height)
        }
    }
    
}

// MARK: - Touching
extension UIView {
    
    /// Set `isUserInteractionEnabled` for all subviews in view.
    func disableUserInteractionInSubviews() {
        self.subviews.forEach {
            $0.disableUserInteractionInSubviews()
            $0.isUserInteractionEnabled = false
        }
    }
}

extension RawRepresentable where RawValue == String {
    
    var localized: String {
        return rawValue.localized
    }
    
}

extension CGFloat {
    
    /// The least positive number for TableView.
    ///
    /// * leastNormalMagnitude and leastNonzeroMagnitude will be treated as minus (hence the crash).
    /// * Zero will make the TableView return the default height as header / footer.
    /// * Anything between zero and one will be treated as a minus.
    /// * One will make the TableView return the default height.
    static var leastPositiveForTableView: CGFloat {
        return CGFloat.leastNormalMagnitude
    }
}

