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
//    var navigationController: UINavigationController { get set }

    func start()
}
