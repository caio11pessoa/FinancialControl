//
//  FloatModifiers.swift
//  coreDataPra
//
//  Created by Caio de Almeida Pessoa on 15/07/24.
//

import Foundation

extension Float {
    func decimalPlaces(_ places: Int = 2) -> String {
        return String(format: "%.\(places)f", self)
    }
    func toStringDecimalPlaces(_ places: Int = 2) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        guard let formattedValue = formatter.string(from: NSNumber(value: self)) else { return String(self) }
        return formattedValue
    }
    
    var twoDecimalPlaces: String { String(format: "%.2f", self)}
}
