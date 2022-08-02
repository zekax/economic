//
//  DetailsViewController.swift
//  economic
//
//  Created by José Rodrigues on 01/08/2022.
//

import UIKit

class DetailsViewController: UIViewController {

    weak var coordinator: MainCoordinator!
    var viewModel: DetailsViewModel!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        fillData()
    }
    
    func fillData(){
        titleLabel.text = viewModel.receipt.title
        dateLabel.text = viewModel.receiptDate
        typeLabel.text = viewModel.receipt.type
        valueLabel.text = viewModel.receiptValue
        descriptionLabel.text = viewModel.receipt.details
        imageView.image = viewModel.receiptImage
        
    }
}
