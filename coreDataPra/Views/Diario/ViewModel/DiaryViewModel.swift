//
//  DiaryViewModel.swift
//  coreDataPra
//
//  Created by Caio de Almeida Pessoa on 19/07/24.
//

import SwiftUI

class DiaryViewModel: ViewModelBase, ObservableObject {
    
    @Published var selectedMonth: String
    
    var isCurrentMonth: Bool {
        selectedMonth == Date.now.formatted(.dateTime.month(.twoDigits))
    }
    
    override init(database: DataBaseManager) {
        selectedMonth = Date.now.formatted(.dateTime.month(.twoDigits))
        super.init(database: database)
    }
    
    func filterDay(_ day: String) -> Bool {
        let dateNow: Date = .now
        if let intDay = Int(day),
           let intDayNow = Int(dateNow.formatted(.dateTime.day(.twoDigits))){
            return intDay >= intDayNow
        }
        return false
    }
    
    var gastoPrevisto: Float {
        let daysUntilMonthEntil: Int = allDays.filter(filterDay).count
        
        if let floatExpectedSaving = Float(AppStorageManager.expectedSaving){
            return (totalGastoMes - floatExpectedSaving) / Float(daysUntilMonthEntil)
        } else {
            return totalGastoMes / Float(daysUntilMonthEntil)
        }
    }
    
    var totalGastoMes: Float {
        var total: Float = 0
        monthMoviments.forEach { mov in
            total += mov.valor
        }
        return total
    }
    
    // Podemos setar esses valores em um userDefaults
    func returnColor(val: Float) -> Color {
        if(val > 2 * gastoPrevisto){
            return .red
        }else if(val > gastoPrevisto) {
            return .yellow
        }else if(val > gastoPrevisto/2){
            return .blue
        } else {
            return .green
        }
    }
    
    var monthMoviments: [Moviment]{
        moviments.filter { movi in
            if movi.date?.formatted(.dateTime.month(.twoDigits)) == selectedMonth{
                return true
            }
            return false
        }
    }
    
    private func filterMovimentsPerDay(_ day: String) -> [Moviment]{
        monthMoviments.filter { movi in
            if movi.date?.formatted(.dateTime.day()) == day {
                return true
            }else { return false}
        }
    }
    
    private func sumAllMoviValues(_ movi: [Moviment]) -> Float {
        var value: Float = 0
        movi.forEach { movi in
            value += movi.valor
        }
        return value
    }
    
    var dailyMoviments: [MovimentPerDay] {
        var daily: [MovimentPerDay] = []
        allDays.forEach { day in
            
            var moviDay: MovimentPerDay = .init(day: .now, moviment: [], valor: 0)
            
            moviDay.moviment = filterMovimentsPerDay(day)
            moviDay.valor = sumAllMoviValues(moviDay.moviment)
            
            
            if let intDay = Int(day),
               let intMonth = Int(selectedMonth) {
                let dateComponents = DateComponents(
                    year: 2024,
                    month: intMonth,
                    day: intDay
                )
                if let calendarDate = Calendar.current.date(from: dateComponents) {
                    moviDay.day = calendarDate
                }
            }
            
            daily.append(moviDay)
        }
        return daily
    }
    
    var allDays: [String] {
        guard let selectedMonth = Int(selectedMonth),
              let date = Calendar.current.date(
                from: DateComponents(
                    year: Calendar.current.component(.year, from: Date()),
                    month: selectedMonth
                )
              )
        else { return [] }
        
        let range = Calendar.current.range(of: .day, in: .month, for: date)!
        return range.map { String($0) }
    }
}
