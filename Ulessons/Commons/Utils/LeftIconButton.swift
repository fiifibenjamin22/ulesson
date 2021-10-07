//
//  RightIconButton.swift
//  Ulessons
//
//  Created by Benjamin Acquah on 10/5/21.
//

import UIKit

class LeftIconButton: UIButton {
    
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
        
        contentHorizontalAlignment = .left
        titleLabel?.font = UIFont.custom(ofSize: Constants.FontSize.body, font: UIFont.Roboto.regular)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentEdgeInsets = UIEdgeInsets(padding: buttonPadding).insetBy(dx: spacing, dy: 0)
        titleEdgeInsets = UIEdgeInsets(top: 0, left: spacing, bottom: 0, right: -spacing)
        imageEdgeInsets = UIEdgeInsets(top: 0, left: -spacing, bottom: 0, right: spacing)
    }
}

extension UIView {
    
    func applyTouchAnimation() {
        let gestureRec = TouchGestureRecognizer()
        gestureRec.addAction(
            beginAction: { [unowned self] _ in
                self.animateTouchedDown()
        }, endAction: { [unowned self] in
            self.animateTouchedUp()
        })
        addGestureRecognizer(gestureRec)
    }
    
    @objc private func animateTouchedDown(completion: (() -> Void)? = nil) {
        UIView.animate(withDuration: 0.1, animations: {
            if self.hasShadow {
                self.layer.shadowOpacity = 0
            }
            self.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        }) {_ in
            if self is UIControl {
                UIImpactFeedbackGenerator().impactOccurred()
            }
            completion?()
        }
    }
    
    @objc private func animateTouchedUp(completion: (() -> Void)? = nil) {
        UIView.animate(withDuration: 0.1, animations: {
            if self.hasShadow {
                self.layer.shadowOpacity = UIView.defaultShadowOpacity
            }
            self.transform = CGAffineTransform(scaleX: 1, y: 1)
        }) {_ in
            completion?()
        }
    }
}

