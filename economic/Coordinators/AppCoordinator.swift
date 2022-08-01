//
//  AppCoordinator.swift
//  economic
//
//  Created by José Rodrigues on 31/07/2022.
//

import Foundation
import UIKit

class AppCoordinator{
    var mainCoordinator: MainCoordinator?
    var window: UIWindow?
                 
    func start() {
        self.mainCoordinator = MainCoordinator()
        mainCoordinator?.start()
        self.window?.rootViewController = mainCoordinator?.navigationController
    }
    
    // MARK: - Init
    public init(window: UIWindow) {
        self.window = window
        self.window?.makeKeyAndVisible()
    }
    
}
