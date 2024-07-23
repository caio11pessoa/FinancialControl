//
//  DatabaseManager.swift
//  coreDataPra
//
//  Created by Caio de Almeida Pessoa on 18/07/24.
//

import Foundation
import CoreData

class DataBaseManager {
    let container: NSPersistentContainer

    init() {
        container = NSPersistentContainer(name: "Bookworm")
        container.loadPersistentStores { description, error in
            if let error = error {
                print("ERROR LOADING CORE DATA. \(error)")
            }
        }
    }
    func fetchMoviments() -> [Moviment]{
        var moviments: [Moviment] = []
        let request = NSFetchRequest<Moviment>(entityName: "Moviment")

        do {
            moviments = try container.viewContext.fetch(request)
        } catch let error {
            print("Error fetching. \(error)")
        }
        return moviments
    }
    
    func addMoviment(value: Float, date: Date, receita: Bool, tag: TagEnum, desc: String) {
        if value != 0 {
            let newMoviment = Moviment(context: container.viewContext)
            newMoviment.valor = receita ? value : -value
            newMoviment.date = date
            newMoviment.id = UUID()
            newMoviment.tag = tag.rawValue
            newMoviment.descricao = desc
            saveData()
        }
    }
    
    //    func updateFruit(entity: FruitEntity) {
    //        let currentName = entity.name ?? ""
    //        let newName = currentName + "!"
    //        entity.name = newName
    //        saveData()
    //    }

    func deleteMoviment(_ moviment: Moviment){
        let entity = moviment
        container.viewContext.delete(entity)
        saveData()
    }
    
    func saveData() {
        do {
            try container.viewContext.save()
        } catch let error {
            print("Error saving. \(error)")
        }
    }
}
