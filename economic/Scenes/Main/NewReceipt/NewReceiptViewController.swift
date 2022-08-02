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
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var typePicker: UIPickerView!
    @IBOutlet weak var currencyPicker: UIPickerView!
    
    @IBOutlet weak var keyboardHeightLayoutConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardNotification), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard(_:)))
        self.view.addGestureRecognizer(tap)
        
        capturedImage.image = viewModel.image
        setDatePicker()
        setTypePicker()
        setCurrencyPicker()
    }
    
    func setCurrencyPicker(){
        currencyPicker.delegate = self
        
        currencyTxtFld.text = viewModel.selectedCurrency.code + " " + viewModel.selectedCurrency.symbol
        currencyTxtFld.inputView = currencyPicker
        currencyTxtFld.inputAccessoryView = getPickerToolbar()
    }
    
    func setTypePicker(){
        typePicker.delegate = self
        
        typeTxtFld.text = receiptType.none.rawValue
        typeTxtFld.inputView = typePicker
        typeTxtFld.inputAccessoryView = getPickerToolbar()
    }
    
    func setDatePicker(){
        dateTxtFld.text = viewModel.date.formatted(date: .numeric, time: .shortened)
        dateTxtFld.inputView = datePicker
        dateTxtFld.inputAccessoryView = getPickerToolbar()
    }
    
    func getPickerToolbar() -> UIToolbar{
        let doneBtn = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.donePickerPressed))
        let toolbar = UIToolbar()
        toolbar.barStyle = .default
        toolbar.isTranslucent = true
        toolbar.setItems([doneBtn], animated: false)
        toolbar.isUserInteractionEnabled = true
        toolbar.sizeToFit()
        
        return toolbar
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
        currencyTxtFld.text = viewModel.selectedCurrency.code + " " + viewModel.selectedCurrency.symbol
        self.view.endEditing(true)
    }
    
    @IBAction func touchSaveButton(_ sender: Any) {
        
        //TODO: check empty title and show alert
        viewModel.createReceipt(title: titleTxtFld.text ?? String(), type: typeTxtFld.text!, value: valueTxtFld.text ?? String(), description: descriptionTxtFld.text)
        
        self.navigationController?.popViewController(animated: true)
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
        if pickerView == currencyPicker{
            return Currency.allCurrencies.count
        }
        
        //default-typePicker
        return receiptType.allCases.count
    }
}

extension NewReceiptViewController: UIPickerViewDelegate{
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if pickerView == currencyPicker{
            viewModel.selectedCurrency = Currency.allCurrencies[row]
//            currencyTxtFld.text = viewModel.selectedCurrency.code + " " + viewModel.selectedCurrency.symbol
            return "\(Currency.allCurrencies[row].name) :: \(Currency.allCurrencies[row].code) :: \(Currency.allCurrencies[row].symbol)"
        }
        
        //default-typePicker
        typeTxtFld.text = receiptType.allCases[row].rawValue
        return receiptType.allCases[row].rawValue
    }
}

