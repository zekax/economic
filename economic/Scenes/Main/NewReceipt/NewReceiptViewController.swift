//
//  NewReceiptViewController.swift
//  economic
//
//  Created by José Rodrigues on 01/08/2022.
//

import UIKit

class NewReceiptViewController: UIViewController {

    var viewModel: NewReceiptViewModel!
    weak var coordinator: MainCoordinator?
    
    @IBOutlet weak var capturedImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        capturedImage.image = viewModel.image
        // Do any additional setup after loading the view.
    }
    
    @IBAction func touchSaveButton(_ sender: Any) {
    }
}
