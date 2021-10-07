//
//  CommonClasses.swift
//  Ulessons
//
//  Created by Benjamin Acquah on 10/6/21.
//

import Foundation
import UIKit

class CommonClass {
    
    static func showLoader() {
        let screenHeight = UIScreen.main.bounds.height
        let screenWidth = UIScreen.main.bounds.width
        
        let frameRect = CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight)
        let dimImage = UIImageView(frame: frameRect)
        dimImage.backgroundColor = UIColor.black
        dimImage.alpha = 0.5
        
        let activityIndicator = UIActivityIndicatorView(frame: frameRect)
        activityIndicator.startAnimating()
        
        let loaderView = UIView(frame: frameRect)
        loaderView.addSubview(dimImage)
        loaderView.addSubview(activityIndicator)
        
        loaderView.tag = 999
        DispatchQueue.main.async {
            UIApplication.shared.keyWindow?.addSubview(loaderView)
        }
    }
    
    static func hideLoader() {
        DispatchQueue.main.async {
            if let loaderView = UIApplication.shared.keyWindow?.viewWithTag(999) {
                loaderView.removeFromSuperview()
            }
        }
    }
    
    static func alert(title: String?, message: String?) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertController.addAction(okAction)
        UIApplication.topViewController()?.present(alertController, animated: true, completion: nil)
    }
    
    
}

extension UIApplication {
    class func topViewController(controller: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let navigationController = controller as? UINavigationController {
            return topViewController(controller: navigationController.visibleViewController)
        }
        if let tabController = controller as? UITabBarController {
            if let selected = tabController.selectedViewController {
                return topViewController(controller: selected)
            }
        }
        if let presented = controller?.presentedViewController {
            return topViewController(controller: presented)
        }
        return controller
    }
}
