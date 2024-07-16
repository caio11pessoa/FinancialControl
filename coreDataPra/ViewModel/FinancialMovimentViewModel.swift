//
//  FinancialMovimentViewModel.swift
//  coreDataPra
//
//  Created by Caio de Almeida Pessoa on 11/07/24.
//

import SwiftUI
import CoreData

class FinancialMovimentViewModel: ObservableObject {
    let container: NSPersistentContainer
    @Published var moviments: [Moviment] = []
    @Published var isShowingSheet: Bool = false
    @Published var sorted: Bool = false
    @Published var newValue: String = ""
    @Published var receita: Bool = false
    @Published var newDate: Date = .now
    @Published var isLines: Bool = false
    
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
    
    struct MovimentPerDay: Identifiable{
        var day: Date
        var moviment: [Moviment]
        var valor: Float
        var id: Date {day}
    }
    
    var ganhosPorDia: [MovimentPerDay] {
        var moviPerDay: [MovimentPerDay] = []
        var oldDay: Date = .distantPast
        var index = -1
        
        movimentsSorted.forEach { movi in
            if(movi.valor >= 0){
                if oldDay != movi.date {
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
        print(oldDay)
        var index = -1
        
        movimentsSorted.forEach { movi in
            if(movi.valor < 0){
                if oldDay != movi.date {
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
    
    init() {
        container = NSPersistentContainer(name: "Bookworm")
        container.loadPersistentStores { description, error in
            if let error = error {
                print("ERROR LOADING CORE DATA. \(error)")
            }
        }
        fetchMoviments()
    }
    
    func fetchMoviments() {
        let request = NSFetchRequest<Moviment>(entityName: "Moviment")

        do {
            moviments = try container.viewContext.fetch(request)
        } catch let error {
            print("Error fetching. \(error)")
        }
    }
    
    func addMoviment(value: Float, date: Date, receita: Bool) {
        if value != 0 {
            let newMoviment = Moviment(context: container.viewContext)
            newMoviment.valor = receita ? value : -value
            newMoviment.date = date
            newMoviment.id = UUID()
            saveData()
        }
    }
    
    //    func updateFruit(entity: FruitEntity) {
    //        let currentName = entity.name ?? ""
    //        let newName = currentName + "!"
    //        entity.name = newName
    //        saveData()
    //    }

    func deleteMoviment(indexSet: IndexSet){
        guard let index = indexSet.first else {return}
        let entity = sorted ? movimentsSorted[index] : moviments[index]
        container.viewContext.delete(entity)
        saveData()
    }
    
    func saveData() {
        do {
            try container.viewContext.save()
            fetchMoviments()
        } catch let error {
            print("Error saving. \(error)")
        }
    }
}

struct CoreDataManager {
    
}
