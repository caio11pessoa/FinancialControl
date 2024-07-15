//
//  DateModifiers.swift
//  coreDataPra
//
//  Created by Caio de Almeida Pessoa on 15/07/24.
//

import Foundation

extension Date {
    func dateFormated(_ types: [TypeFormatedEnum] = [.yearMonthAndDay]) -> String {
        let dateFormatter = DateFormatter()
        var finalType = ""
        types.forEach { type in
            finalType += " " + type.rawValue
        }
        dateFormatter.dateFormat = finalType
        let dateString = dateFormatter.string(from: self)
        return dateString
    }
    func dateFormated2(_ types: [TypeFormatedEnum] = [.yearMonthAndDay]) -> String {
        let dateFormatter = DateFormatter()
        var finalType = ""
        types.forEach { type in
            finalType += " " + type.rawValue
        }
        dateFormatter.dateFormat = finalType
        let dateString = dateFormatter.string(from: self)
        return dateString
    }
}

enum TypeFormatedEnum: String {
    case year = "yyyy"
    case day = "dd"
    case month = "MM"
    case monthAndDay = "MM/dd"
    case yearMonthAndDay = "yyyy/MM/dd"
    case time = "HH:mm:ss"
    case hour = "HH"
    case minuts = "mm"
    case seconds = "ss"
    case dateAndTime = "yyyy-MM-dd HH:mm:ss"
}
