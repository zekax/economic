//
//  NewReceptViewModel.swift
//  economic
//
//  Created by José Rodrigues on 01/08/2022.
//

import Foundation
import UIKit
import CoreData

class NewReceiptViewModel{
    
    var image: UIImage
    var date = Date()
    var selectedCurrency: Currency = {
        let currencyFormatter = NumberFormatter()
        currencyFormatter.locale = Locale.current
        return Currency(name: Locale.current.localizedString(forCurrencyCode: currencyFormatter.currencyCode) ?? String(), code: currencyFormatter.currencyCode, symbol: currencyFormatter.currencySymbol)
    }()
    
    init(image: UIImage){
        self.image = image
    }
    
    func createReceipt(title: String, date: Date, type:String, value:Double, currency: String, description:String, image: UIImage){
        let receipt = NSEntityDescription.insertNewObject(forEntityName: "Receipt", into: PersistenceService.persistentContainer.viewContext) as! Receipt
        
        receipt.title = title
        receipt.date = date
        receipt.type = type
        receipt.totalValue = value
        receipt.currency = currency
        receipt.details = description
        receipt.imagePath = Utils.savePNGImage(image: image)
        
        PersistenceService.saveContext()
        
    }
}
