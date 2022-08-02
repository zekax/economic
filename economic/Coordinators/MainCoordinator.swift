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
    }
    
    func start() {
        mainController.coordinator = self
    }
    
    func navigateToNew(image: UIImage){
        let newvc = storyboard.instantiateViewController(withIdentifier: "NewReceipt") as! NewReceiptViewController
        newvc.viewModel = NewReceiptViewModel(image: image)
        navigationController.pushViewController(newvc, animated: true)
    }
    
    func navigateToDetails(receipt: Receipt){
        let newvc = storyboard.instantiateViewController(withIdentifier: "ReceiptDetails") as! DetailsViewController
        newvc.viewModel = DetailsViewModel(receipt: receipt)
        navigationController.pushViewController(newvc, animated: true)
    }
    
}
