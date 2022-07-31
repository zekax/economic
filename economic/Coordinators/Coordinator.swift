//
//  Coordinator.swift
//  economic
//
//  Created by José Rodrigues on 31/07/2022.
//

import Foundation
import UIKit

protocol Coordinator {
//    var childCoordinators: [Coordinator] { get set } //we'll be using a single coordinator forthe entire app since there's only one flow
    var navigationController: UINavigationController { get set }

    func start()
    func initializeAsRoot(navigationController: UINavigationController)
}

extension Coordinator{
    func initializeAsRoot(navigationController: UINavigationController){
        var window: UIWindow?
        if #available(iOS 13.0, *) {
            let appDelegate = UIApplication.shared.connectedScenes.first!.delegate as! SceneDelegate
            window = appDelegate.window
        } else {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            window = appDelegate.window
        }
        
        window?.rootViewController?.dismiss(animated: false, completion: {
            window?.rootViewController = navigationController
        })
    }
}
