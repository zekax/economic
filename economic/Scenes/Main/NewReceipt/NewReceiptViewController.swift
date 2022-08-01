//
//  NewReceiptViewController.swift
//  economic
//
//  Created by José Rodrigues on 01/08/2022.
//

import UIKit

enum receiptType: String, CaseIterable{
    case none = "None"
    case travel = "Travel"
    case shopping = "Shopping"
    case groceries = "Groceries"
    case other = "Other"
    
}

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
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var typePicker: UIPickerView!
    
    var pickerData = [String]()
    
    @IBOutlet weak var keyboardHeightLayoutConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardNotification), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard(_:)))
        self.view.addGestureRecognizer(tap)
        
        capturedImage.image = viewModel.image
        setDatePicker()
        setTypePicker()
        setCurrency()
    }
    
    func setCurrency(){
        let currencyFormatter = NumberFormatter()
        currencyFormatter.locale = Locale.current
        
        currencyTxtFld.text = currencyFormatter.currencyCode
    }
    
    
    func setTypePicker(){
        typeTxtFld.text = receiptType.none.rawValue
        typeTxtFld.inputView = typePicker
        
        typePicker.delegate = self
        let doneBtn = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.donePickerPressed))
        let toolbar = UIToolbar()
        toolbar.barStyle = .default
        toolbar.isTranslucent = true
        toolbar.setItems([doneBtn], animated: false)
        toolbar.isUserInteractionEnabled = true
        toolbar.sizeToFit()
        
        typeTxtFld.inputAccessoryView = toolbar
    }
    
    func setDatePicker(){
        dateTxtFld.text = viewModel.date.formatted(date: .numeric, time: .shortened)
        dateTxtFld.inputView = datePicker
        
        let doneBtn = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.donePickerPressed))
        let toolbar = UIToolbar()
        toolbar.barStyle = .default
        toolbar.isTranslucent = true
        toolbar.setItems([doneBtn], animated: false)
        toolbar.isUserInteractionEnabled = true
        toolbar.sizeToFit()
        
        dateTxtFld.inputAccessoryView = toolbar
    }
    
    @objc func dismissKeyboard(_ sender: UITapGestureRecognizer)
    {
        self.view.endEditing(true)
    }
    
    @IBAction func datePickerValueChanged(_ sender: UIDatePicker) {
        viewModel.date = sender.date
        dateTxtFld.text = viewModel.date.formatted(date: .numeric, time: .shortened)
    }
                                      
    @objc func donePickerPressed(_ sender: Any)
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

extension NewReceiptViewController: UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return receiptType.allCases.count
    }
}

extension NewReceiptViewController: UIPickerViewDelegate{
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        typeTxtFld.text = receiptType.allCases[row].rawValue
        return receiptType.allCases[row].rawValue
    }
}
