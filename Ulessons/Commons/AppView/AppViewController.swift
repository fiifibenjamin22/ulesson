//
//  AppViewController.swift
//  Ulessons
//
//  Created by Benjamin Acquah on 9/29/21.
//

import UIKit

typealias AppViewController = AppViewControllerClass

class AppViewControllerClass: UIViewController {
    
    lazy var router = Router(viewController: self)
    
    var includeNavBarSafeAreaInsets: Bool {
        return true
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.bindUI()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if !includeNavBarSafeAreaInsets,
            let extraHeight = self.navigationController?.navigationBar.frame.height {
            self.additionalSafeAreaInsets = UIEdgeInsets(top: -extraHeight, left: 0, bottom: 0, right: 0)
        }
    }
    
    func bindUI() {}
}
