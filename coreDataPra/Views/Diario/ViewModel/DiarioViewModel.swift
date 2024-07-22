//
//  DiarioViewModel.swift
//  coreDataPra
//
//  Created by Caio de Almeida Pessoa on 19/07/24.
//

import SwiftUI

class DiarioViewModel: ObservableObject {
    var databaseManager: DataBaseManager
    @Published var selectedMonth: String
    var gastoPrevisto: Float {
        let dateNow: Date = .now
        let daysUntilMonthEntil: Int =
        generateDays().filter { day in
            Int(day)! >= Int(dateNow.formatted(.dateTime.day(.twoDigits)))!
        }.count
        return totalGastoMes/Float(daysUntilMonthEntil)
    }
    var totalGastoMes: Float {
        var total: Float = 0
        monthMoviments.forEach { mov in
            total += mov.valor
        }
        return total
    }
    init() {
        databaseManager = .init()
        moviments = databaseManager.fetchMoviments()
        selectedMonth = Date.now.formatted(.dateTime.month(.twoDigits))
        var totalDias: [String]{ guard let selectedMonth = Int(selectedMonth),
                                       let date = Calendar.current.date(from: DateComponents(year: Calendar.current.component(.year, from: Date()), month: selectedMonth)) else {
            return []
        }
            
            let range = Calendar.current.range(of: .day, in: .month, for: date)!
            return range.map { String($0) }
        }
    }
    
    @Published var moviments: [Moviment] = []
    
    func returnColor(val: Float) -> Color {
        print("Val: \(val) Gasto Previsto: \(gastoPrevisto)")
        if(val > 2*gastoPrevisto){
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
    
    var dailyMoviments: [MovimentPerDay] {
        var daily: [MovimentPerDay] = []
        generateDays().forEach { day in
            var moviDay: MovimentPerDay = .init(day: .now, moviment: [], valor: 0)
            let daysFiltered = monthMoviments.filter { movi in
                if movi.date?.formatted(.dateTime.day()) == day{
                    return true
                }else { return false}
            }
            moviDay.moviment = daysFiltered
            var dateComponents = DateComponents()
            dateComponents.day = Int(day)!
            dateComponents.month = Int(selectedMonth)!
            dateComponents.year = 2024
            let calendar = Calendar.current
            moviDay.day = calendar.date(from: dateComponents)!
            print(moviDay.day)
            daysFiltered.forEach { movi in
                moviDay.valor += movi.valor
            }
            daily.append(moviDay)
        }
        return daily
    }
    
    var MoviPorDia: [MovimentPerDay] {
        var moviPerDay: [MovimentPerDay] = []
        var oldDay: Date = .distantPast
        var index = -1
        
        monthMoviments.forEach { movi in
            if oldDay.formatted(.dateTime
                .day()
                .month(.twoDigits)
                .year()) != movi.date?.formatted(.dateTime
                    .day()
                    .month(.twoDigits)
                    .year()) {
                index += 1
                moviPerDay.append(.init(day: movi.date!, moviment: [movi], valor: movi.valor))
            }
            else {
                moviPerDay[index].moviment.append(movi)
                moviPerDay[index].valor += movi.valor
            }
            oldDay = movi.date!
        }
        
        return moviPerDay
    }
    
    private func generateDays() -> [String] {
        guard let selectedMonth = Int(selectedMonth),
              let date = Calendar.current.date(from: DateComponents(year: Calendar.current.component(.year, from: Date()), month: selectedMonth)) else {
            return []
        }
        
        let range = Calendar.current.range(of: .day, in: .month, for: date)!
        return range.map { String($0) }
    }
    
    func addMoviment(value: Float, date: Date, receita: Bool, tag: TagEnum, desc: String) {
        if value != 0 {
            databaseManager.addMoviment(value: value, date: date, receita: receita, tag: tag, desc: desc)
            saveData()
        }
    }

    func deleteMoviment(indexSet: IndexSet){
        guard let index = indexSet.first else {return}
        let entity = moviments[index]
        databaseManager.deleteMoviment(entity)
        saveData()
    }
    
    func saveData() {
        databaseManager.saveData()
        moviments = databaseManager.fetchMoviments()
    }
}

struct MovimentPerDay: Identifiable{
    var day: Date
    var moviment: [Moviment]
    var valor: Float
    var id: Date {day}
}
