//
//  ViewController.swift
//  economic
//
//  Created by José Rodrigues on 31/07/2022.
//

import UIKit

class MainViewController: UIViewController{

    weak var coordinator: MainCoordinator?
    var imagePicker:UIImagePickerController!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
    }

    @IBAction func touchAddButton(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera) {
            
            self.imagePicker.sourceType = .camera;
            self.imagePicker.allowsEditing = true
            self.present(self.imagePicker, animated: true, completion: nil)
        }
    }
    
}


extension MainViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
//            savePNGImage(image: image)
//            coordinator.navigateToNewReceipt
        }
        self.dismiss(animated: true, completion: nil);
    }
    
    func savePNGImage(image: UIImage)-> String{
        
        let filename:String = UUID().uuidString + ".png"
        
        let documentDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        
        let fileURL = URL(fileURLWithPath: documentDirectory).appendingPathComponent(filename)
        
        let data = image.pngData()
        try? data?.write(to: fileURL)
        
        return filename
    }
}
