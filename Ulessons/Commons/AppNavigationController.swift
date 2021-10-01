//
//  AppNavigationController.swift
//  Ulessons
//
//  Created by Benjamin Acquah on 9/28/21.
//

import UIKit

final class AppNavigationController: UINavigationController {

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return topViewController?.preferredStatusBarStyle ?? .default
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    private func setup() {
        self.delegate = self
        self.navigationBar.isTranslucent = false
        self.navigationBar.tintColor = UIColor.appText
        self.navigationBar.titleTextAttributes = titleTextAttributes(withColor: UIColor.appText)
        self.interactivePopGestureRecognizer?.delegate = self
        self.interactivePopGestureRecognizer?.isEnabled = true
        self.navigationBar.backIndicatorImage = Icons.Common.backIcon
        self.navigationBar.backIndicatorTransitionMaskImage = Icons.Common.backIcon
    }
    
    func titleTextAttributes(withColor color: UIColor) -> [NSAttributedString.Key: Any] {
        return [NSAttributedString.Key.font: UIFont.custom(ofSize: Constants.FontSize.tiny, font: UIFont.Roboto.bold),
                NSAttributedString.Key.kern: CGFloat(1.3),
                NSAttributedString.Key.foregroundColor: color]
    }
}

extension AppNavigationController: UINavigationControllerDelegate {

    func navigationController(
        _ navigationController: UINavigationController,
        animationControllerFor operation: UINavigationController.Operation,
        from fromVC: UIViewController,
        to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {

        switch (fromVC, toVC, operation) {
        default: return nil
        }

    }
    
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        let item = UIBarButtonItem(title: " ", style: .plain, target: nil, action: nil)
        viewController.navigationItem.backBarButtonItem = item
    }
}

extension AppNavigationController: UIGestureRecognizerDelegate {
    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
