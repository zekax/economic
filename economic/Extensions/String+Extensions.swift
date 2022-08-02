//
//  String+Extensions.swift
//  economic
//
//  Created by José Rodrigues on 02/08/2022.
//

import Foundation

extension String {
    var doubleValue: Double {
        let numberFormatter = NumberFormatter()
        numberFormatter.decimalSeparator = ","
        if let result = numberFormatter.number(from: self) {
            return result.doubleValue
        }
        return 0
    }
}


extension Double {
    var stringValue: String {
        let numberFormatter = NumberFormatter()
        numberFormatter.decimalSeparator = ","
        if let result = numberFormatter.number(from: self.description) {
            return result.stringValue
        }
        return "0"
    }
}
