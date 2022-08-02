//
//  DetailsViewModel.swift
//  economic
//
//  Created by José Rodrigues on 02/08/2022.
//

import Foundation
import UIKit

class DetailsViewModel{
    
    var receipt: Receipt
    
    init(receipt: Receipt){
        self.receipt = receipt
    }
    
    var receiptDate: String {
        get{
            return receipt.date?.formatted(date: .numeric, time: .shortened) ?? "N/A"
        }
    }
    var receiptValue: String {
        get{
            let formatter = NumberFormatter()
            formatter.numberStyle = .currency
            formatter.currencyCode = receipt.currency
            
            return formatter.string(from: receipt.totalValue as NSNumber) ?? "N/A"
        }
    }
    var receiptImage: UIImage {
        get{
            return Utils.loadPNGImage(filename: receipt.imagePath ?? "") ?? UIImage()
        }
    }
}
