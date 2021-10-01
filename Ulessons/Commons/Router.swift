//
//  Router.swift
//  Ulessons
//
//  Created by Benjamin Acquah on 9/30/21.
//

import Foundation
import UIKit

class Router {

    private weak var viewController: UIViewController?

    init(viewController: UIViewController?) {
        self.viewController = viewController
    }

    func present(destination: Destination, animated: Bool = true, withStyle style: UIModalPresentationStyle = .fullScreen) {
        let destinationViewController = destination.viewController
        destinationViewController.modalPresentationStyle = style
        guard let viewController = viewController, !viewController.isKind(of: destinationViewController.classForCoder) else { return }
        viewController.present(destinationViewController, animated: animated)
    }

    func push(destination: Destination, animated: Bool = true) {
        let destinationViewController = destination.viewController
        viewController?.navigationController?.pushViewController(destinationViewController, animated: animated)
    }
}
