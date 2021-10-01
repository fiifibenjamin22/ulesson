//
//  UIViewControllerExtension.swift
//  Ulessons
//
//  Created by Benjamin Acquah on 9/28/21.
//

import UIKit

extension UIViewController {
    
    var statusBar: UIView? {
        return UIApplication.shared.statusBar
    }
    
    var top: UIViewController? {
        switch self {
        case is UINavigationController:
            return (self as? UINavigationController)?.topViewController?.top
        case is UISplitViewController:
            return (self as? UISplitViewController)?.viewControllers.last?.top
        case is UITabBarController:
            return (self as? UITabBarController)?.selectedViewController?.top
        default:
            break
        }
        if let controller = presentedViewController {
            return controller.top
        }
        return self
    }
    
    func embedInNavigationController() -> AppNavigationController {
        return AppNavigationController(rootViewController: self)
    }
    
    func addChild(viewController: UIViewController, inside container: UIView) {
        addChild(viewController)
        
        container.addSubview(viewController.view)
        viewController.view.edges(equalTo: container)
        
        viewController.didMove(toParent: self)
    }
    
    func removeChild(viewController: UIViewController) {
        viewController.view.removeFromSuperview()
        viewController.removeFromParent()
        viewController.didMove(toParent: nil)
    }
    
    /// Adding gesture recognizer to whole view
    /// which close keyboard on tap outside
    func hideKeyboardOnTapOutside() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc func dismiss(animated: Bool = true) {
        if let navigationController = navigationController {
            if self == navigationController.viewControllers.first {
                navigationController.dismiss(animated: animated, completion: nil)
            } else {
                navigationController.popViewController(animated: animated)
            }
        } else {
            dismiss(animated: animated, completion: nil)
        }
    }
    
    func disableScrollInsets(for scrollView: UIScrollView) {
        scrollView.contentInsetAdjustmentBehavior = .never
    }
    
}
