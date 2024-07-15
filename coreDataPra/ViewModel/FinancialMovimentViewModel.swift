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
    
    var total: Float {
        var currentValue: Float = 0
        for movi in moviments {
            currentValue += movi.valor
        }
        return currentValue
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
