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
        do {
            self.receiptList = try PersistenceService.persistentContainer.viewContext.fetch(fetchRequest)
            
            delegate?.receiptsFetched()
        }catch{
            print(error.localizedDescription as Any)
        }
    }
}
