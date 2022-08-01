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
    
    @IBOutlet weak var keyboardHeightLayoutConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardNotification), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard(_:)))
        self.view.addGestureRecognizer(tap)
        
        capturedImage.image = viewModel.image
        dateTxtFld.text = Date().formatted(date: .numeric, time: .shortened)
    }
    
    @objc func dismissKeyboard(_ sender: UITapGestureRecognizer)
    {
        self.view.endEditing(true)
    }
    
    @IBAction func touchSaveButton(_ sender: Any) {
    }
    
    @objc func keyboardNotification(notification: Notification) {
        if let userInfo = notification.userInfo {
            let endFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
            let endFrameY = endFrame?.origin.y ?? 0
            let duration:TimeInterval = (userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue ?? 0
            let animationCurveRawNSN = userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? NSNumber
            let animationCurveRaw = animationCurveRawNSN?.uintValue ?? UIView.AnimationOptions.curveEaseInOut.rawValue
            let animationCurve:UIView.AnimationOptions = UIView.AnimationOptions(rawValue: animationCurveRaw)
            if endFrameY >= UIScreen.main.bounds.size.height {
                self.keyboardHeightLayoutConstraint?.constant = 0.0
            } else {
                self.keyboardHeightLayoutConstraint?.constant = (endFrame?.size.height ?? 0.0)
            }
            
            UIView.animate(withDuration: duration,
                           delay: TimeInterval(0),
                           options: animationCurve,
                           animations: {
                            self.view.layoutIfNeeded()},
                           completion: nil)
        }
    }
}
