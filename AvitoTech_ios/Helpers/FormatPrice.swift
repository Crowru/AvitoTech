//
//  FormatPrice.swift
//  AvitoTech
//
//  Created by Руслан  on 30.08.2023.
//

import Foundation

func formatPrice(_ price: String) -> String {
    let formatter = NumberFormatter()
    formatter.numberStyle = .decimal
    
    let priceComponents = price.components(separatedBy: " ")
    if let priceValue = Double(priceComponents[0]),
       let formattedPrice = formatter.string(from: NSNumber(value: priceValue)) {
        
        let formattedPriceWithCurrency = "\(formattedPrice) \(priceComponents[1])"
        return formattedPriceWithCurrency
    }
    
    return price
}
