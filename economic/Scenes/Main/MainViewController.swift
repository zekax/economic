//
//  ViewController.swift
//  economic
//
//  Created by José Rodrigues on 31/07/2022.
//

import UIKit

class MainViewController: UIViewController {

    weak var coordinator: MainCoordinator?
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func touchAddButton(_ sender: Any) {
    }
    
}

