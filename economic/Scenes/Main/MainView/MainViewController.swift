//
//  ViewController.swift
//  economic
//
//  Created by José Rodrigues on 31/07/2022.
//

import UIKit

class MainViewController: UIViewController{

    weak var coordinator: MainCoordinator!
    var viewModel: MainViewModel!
    var imagePicker:UIImagePickerController!
    @IBOutlet weak var tableView: UITableView!
    private var loaderView: LoaderView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        viewModel.delegate = self
        loaderView = LoaderView(background: true, frame: view.frame)
        loaderView.hideLoader()
        self.view.addSubview(loaderView)
        self.view.bringSubviewToFront(loaderView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loaderView.showLoader()
        viewModel.fetchReceipts()
    }

    @IBAction func touchAddButton(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera) {
            self.imagePicker.sourceType = .camera;
            self.imagePicker.allowsEditing = true
            self.present(self.imagePicker, animated: true, completion: nil)
        }
    }
}

extension MainViewController: ReceiptsDelegate{
    func receiptsFetched() {
        tableView.reloadData()
        loaderView.hideLoader()
    }
}


extension MainViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            self.coordinator?.navigateToNew(image: image)
        }
        self.dismiss(animated: true, completion: nil);
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.receiptList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "receiptlistcell", for: indexPath) as! MainTableViewCell
        
        let receipt = viewModel.getReceipt(for: indexPath.row)
        
        cell.titleLabel.text = receipt.title
        cell.dateLabel.text = receipt.date?.formatted(date: .numeric, time: .shortened)
        cell.typeLabel.text = receipt.type
        cell.valueLabel.text = viewModel.getcCurrencyValue(from: receipt.totalValue, with: receipt.currency)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let receipt = viewModel.getReceipt(for: indexPath.row)
        coordinator.navigateToDetails(receipt: receipt)
    }
}
