//
//  MainCoordinator.swift
//  economic
//
//  Created by José Rodrigues on 31/07/2022.
//

import Foundation
import UIKit

class MainCoordinator: Coordinator{
    
    var navigationController: UINavigationController
    var mainController: MainViewController
    let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        
    init(){
        navigationController = storyboard.instantiateInitialViewController() as! UINavigationController
        mainController = navigationController.viewControllers[0] as! MainViewController
        mainController.viewModel = MainViewModel()
//        navigationController = mainController.navigationController ?? UINavigationController()
    }
    
    func start() {
        mainController.coordinator = self
    }
    
    func navigateToNew(image: UIImage){
        let newvc = storyboard.instantiateViewController(withIdentifier: "NewReceipt") as! NewReceiptViewController
        newvc.viewModel = NewReceiptViewModel(image: image)
        navigationController.pushViewController(newvc, animated: true)
    }
    
    func navigateToDetails(){
        
    }
    
    func exit(vc: UIViewController){
        vc.navigationController?.popViewController(animated: true)
    }
    
}
