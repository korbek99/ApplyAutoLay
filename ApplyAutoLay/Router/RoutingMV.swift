//
//  RoutingMV.swift
//  ApplyAutoLay
//
//  Created by Jose Preatorian on 04-12-24.
//


import Foundation
import UIKit

class RoutingMV {
    var viewController: UIViewController?
    func assignViewController(_ vc: UIViewController) {
        self.viewController = vc
    }
    
    func goToDetailWeb(with hits: Hit) {
        guard let viewController = viewController else {
            print("ViewController is nil")
            return
        }
        if let navigationController = viewController.navigationController {
            let detailVC = WebViewController(hits: hits)
            navigationController.pushViewController(detailVC, animated: true)
        } else {
            print("Navigation controller is not available")
        }
    }
    
    func goToError(error: String) {
        guard let viewController = viewController else {
            print("ViewController is nil")
            return
        }
        if let navigationController = viewController.navigationController {
            let viewerror = ErrorViewController()
            viewerror.errorMessage = error
            navigationController.pushViewController(viewerror, animated: true)
        } else {
            print("Navigation controller is not available")
        }
    }
}
