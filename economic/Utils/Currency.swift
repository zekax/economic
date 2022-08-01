//
//  Currency.swift
//  economic
//
//  Created by José Rodrigues on 01/08/2022.
//

import Foundation


struct Currency {
    let name: String
    let code: String
    let symbol: String
}

extension Currency {
    static var allCurrencies: [Currency] {
        
        let currencies: [Currency] = Locale.commonISOCurrencyCodes.compactMap {
            guard let name = Locale.current.localizedString(forCurrencyCode: $0) else {
                return nil
            }
            let symbol = getSymbol(forCurrencyCode: $0) ?? String()
            return Currency(name: name, code: $0, symbol: symbol)
        }
        return currencies
    }
    
    
    static func getSymbol(forCurrencyCode code: String) -> String? {
        let locale = NSLocale(localeIdentifier: code)
        return locale.displayName(forKey: NSLocale.Key.currencySymbol, value: code)
    }
}
