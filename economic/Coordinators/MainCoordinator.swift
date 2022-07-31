//
//  MainCoordinator.swift
//  economic
//
//  Created by José Rodrigues on 31/07/2022.
//

import Foundation
import UIKit

class MainCoordinator: Coordinator{
    
    
    var mainController: MainViewController
    var navigationController: UINavigationController = UINavigationController()
    let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        
    init(){
        self.mainController = storyboard.instantiateInitialViewController() as! MainViewController
    }
    
    func start() {
        mainController.coordinator = self
    }
    
    func navigateToNew(){
        
    }
    
    func navigateToDetails(){
        
    }
    
}
