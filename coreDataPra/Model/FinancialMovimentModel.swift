//
//  FinancialMovimentModel.swift
//  coreDataPra
//
//  Created by Caio de Almeida Pessoa on 16/07/24.
//

import Foundation

class FinancialMoviment {
    
    var shared: FinancialMovement = .init()
    private var moviments: [Moviment] = []
    
    private var total: Float {
        var currentValue: Float = 0
        for movi in moviments {
            currentValue += movi.valor
        }
        return currentValue
    }
    
    func setMoviments( movis: [Moviment]){
        moviments = movis
    }
}
