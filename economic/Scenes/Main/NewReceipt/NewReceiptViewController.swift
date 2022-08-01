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
    @IBOutlet weak var titleTxtFld: UITextField!
    
    @IBOutlet weak var typeTxtFld: UITextField!
    @IBOutlet weak var dateTxtFld: UITextField!
    @IBOutlet weak var valueTxtFld: UITextField!
    @IBOutlet weak var currencyTxtFld: UITextField!
    @IBOutlet weak var descriptionTxtFld: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        capturedImage.image = viewModel.image
        // Do any additional setup after loading the view.
    }
    
    @IBAction func touchSaveButton(_ sender: Any) {
        
    }
}
