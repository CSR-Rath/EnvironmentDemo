//
//  Double + Extension.swift
//  EnvironmentDemo
//
//  Created by Rath! on 10/6/24.
//

import Foundation

//MARK: Double
extension Double {
    
    var toCurrencyAsKHR : String{
        let currencyCode = "KHR"
        
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.minimumFractionDigits = 2
        numberFormatter.maximumFractionDigits = (currencyCode == "USD") ? 2 : 0
        
        let locale = Locale(identifier: "en_US") // Example: United States
        numberFormatter.locale = locale
        
        let formattedValue = numberFormatter.string(from: NSNumber(value: self)) ?? ""
        
        let separatedValue = formattedValue.replacingOccurrences(of: ",", with: ",")
        let currencyWithCode = "\(currencyCode) \(separatedValue)" + "KHR"
        
        return currencyWithCode
    }
    
    var toCurrencyAsUSD : String{
        
        let currencyCode = "USD"
        
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.minimumFractionDigits = 2
        numberFormatter.maximumFractionDigits = 2
        
        let locale = Locale(identifier: "en_US") // Example: United States
        numberFormatter.locale = locale
        let formattedValue = numberFormatter.string(from: NSNumber(value: self)) ?? ""
        let separatedValue = formattedValue.replacingOccurrences(of: ",", with: ",")
        var currencyWithCode = "\(separatedValue) \(currencyCode)" + "$"
        
        return currencyWithCode
    }
}
