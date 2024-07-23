//
//  FinancialMovimentViewModel.swift
//  coreDataPra
//
//  Created by Caio de Almeida Pessoa on 11/07/24.
//

import SwiftUI

class FinancialMovimentViewModel: ViewModelBase, ObservableObject {
    
    @Published var isShowingSheet: Bool = false
    @Published var sorted: Bool = false
    @Published var newValue: String = ""
    @Published var receita: Bool = false
    @Published var newDate: Date = .now
    @Published var isLines: Bool = false
    @Published var newDescription: String = ""
    
    var total: Float {
        var currentValue: Float = 0
        for movi in moviments {
            currentValue += movi.valor
        }
        return currentValue
    }
    
    var totalGastos: Float {
        var currentValue: Float = 0
        for movi in moviments {
            if movi.valor < 0 {
                currentValue += movi.valor
            }
        }
        return currentValue
    }
    var totalGanhos: Float {
        var currentValue: Float = 0
        for movi in moviments {
            if movi.valor >= 0 {
                currentValue += movi.valor
            }
        }
        return currentValue
    }
    
    var ganhosPorDia: [MovimentPerDay] {
        var moviPerDay: [MovimentPerDay] = []
        var oldDay: Date = .distantPast
        var index = -1
        
        movimentsSorted.forEach { movi in
            if(movi.valor >= 0){
                if oldDay.formatted(.dateTime
                    .day()
                    .month(.twoDigits)
                    .year()) != movi.date?.formatted(.dateTime
                    .day()
                    .month(.twoDigits)
                    .year()) {
                    index += 1
                    moviPerDay.append(.init(day: movi.date!, moviment: [movi], valor: movi.valor))
                }else {
                    moviPerDay[index].moviment.append(movi)
                    moviPerDay[index].valor += movi.valor
                }
                oldDay = movi.date!
            }
        }
        
        return moviPerDay
    }
    var ganhosPorMes: [MovimentPerDay] {
        var moviPerDay: [MovimentPerDay] = []
        var oldDay: Date = .distantPast
        var index = -1
        
        movimentsSorted.forEach { movi in
            if(movi.valor >= 0){
                if oldDay.formatted(.dateTime
                    .month(.twoDigits)
                    .year()) != movi.date?.formatted(.dateTime
                    .month(.twoDigits)
                    .year()) {
                    index += 1
                    moviPerDay.append(.init(day: movi.date!, moviment: [movi], valor: movi.valor))
                }else {
                    moviPerDay[index].moviment.append(movi)
                    moviPerDay[index].valor += movi.valor
                }
                oldDay = movi.date!
            }
        }
        
        return moviPerDay
    }
    
    var gastosPorMes: [MovimentPerDay] {
        var moviPerDay: [MovimentPerDay] = []
        var oldDay: Date = .distantPast
        var index = -1
        
        movimentsSorted.forEach { movi in
            if(movi.valor < 0){
                if oldDay.formatted(.dateTime
                    .month(.twoDigits)
                    .year()) != movi.date?.formatted(.dateTime
                        .month(.twoDigits)
                        .year()) {
                    index += 1
                    moviPerDay.append(.init(day: movi.date!, moviment: [movi], valor: movi.valor))
                }else {
                    moviPerDay[index].moviment.append(movi)
                    moviPerDay[index].valor += movi.valor
                }
                oldDay = movi.date!
            }
        }
        return moviPerDay
    }
    
    var gastosPorDia: [MovimentPerDay] {
        var moviPerDay: [MovimentPerDay] = []
        var oldDay: Date = .distantPast
        var index = -1
        
        movimentsSorted.forEach { movi in
            if(movi.valor < 0){
                if oldDay.formatted(.dateTime
                    .day()
                    .month(.twoDigits)
                    .year()) != movi.date?.formatted(.dateTime
                        .day()
                        .month(.twoDigits)
                        .year()) {
                    index += 1
                    moviPerDay.append(.init(day: movi.date!, moviment: [movi], valor: movi.valor))
                }else {
                    moviPerDay[index].moviment.append(movi)
                    moviPerDay[index].valor += movi.valor
                }
                oldDay = movi.date!
            }
        }
        return moviPerDay
    }
    
    var movimentsSorted: [Moviment] {
        moviments.sorted {
            if $0.date! > $1.date! { return true }
            return false
        }
    }
    
}
