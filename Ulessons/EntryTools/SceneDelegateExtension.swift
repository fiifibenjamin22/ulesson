//
//  AppDelegateExtension.swift
//  Ulessons
//
//  Created by Benjamin Acquah on 9/28/21.
//

import UIKit
import Combine

extension SceneDelegate {
    func setUpInitialScene(windowScene: UIWindowScene) {
        let initialSceneVC: UIViewController = {
            return setUpHomeFlow()
        }()
        
        //make for a switch case to check which scene to present, either auth scene or home scene
        
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        self.window?.rootViewController = initialSceneVC
        self.window?.makeKeyAndVisible()
    }
    
    func setUpHomeFlow() -> UIViewController {
        return LiveLessonController().embedInNavigationController()
    }
}

import UIKit

extension UIApplication {
    
    var statusBar: UIView? {
        if #available(iOS 13.0, *) {
            if let statusBar = self.keyWindow?.viewWithTag(Config.statusBarTag),
                keyWindow?.subviews.last?.tag == Config.statusBarTag {
                return statusBar
            } else {
                keyWindow?.viewWithTag(Config.statusBarTag)?.removeFromSuperview()
                let statusBarView = UIView(frame: UIApplication.shared.statusBarFrame)
                statusBarView.tag = Config.statusBarTag
                
                self.keyWindow?.addSubview(statusBarView)
                return statusBarView
            }
        } else {
            if responds(to: Selector(("statusBar"))) {
                return value(forKey: "statusBar") as? UIView
            }
        }
        return nil
    }
    
}
