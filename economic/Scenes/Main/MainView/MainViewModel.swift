//
//  MainViewModel.swift
//  economic
//
//  Created by José Rodrigues on 02/08/2022.
//

import Foundation
import CoreData


protocol ReceiptsDelegate: AnyObject{
    func receiptsFetched()
}

class MainViewModel{
    
    var receiptList = [Receipt]()
    
    weak var delegate: ReceiptsDelegate?
    
    init(){
    }
    
    func fetchReceipts(){
        let fetchRequest = NSFetchRequest <Receipt>(entityName: "Receipt")
        let descriptor = NSSortDescriptor(key: "date", ascending: false)
        fetchRequest.sortDescriptors = [descriptor]
//        fetchRequest.predicate = NSPredicate(format: "justification != nil")
        DispatchQueue.global().async {
            do {
                self.receiptList = try PersistenceService.persistentContainer.viewContext.fetch(fetchRequest)
                DispatchQueue.main.async {
                    self.delegate?.receiptsFetched()
                }
            }catch{
                print(error.localizedDescription as Any)
            }
        }
    }
    
    func getReceipt(for row: Int) -> Receipt {
        return self.receiptList[row]
    }
    
    
    func getcCurrencyValue(from value: Double, with currency: String?) -> String{
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = currency
        
        return formatter.string(from: value as NSNumber) ?? "N/A"
    }
}
