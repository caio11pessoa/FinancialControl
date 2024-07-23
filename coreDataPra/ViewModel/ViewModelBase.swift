//
//  ViewModelBase.swift
//  coreDataPra
//
//  Created by Caio de Almeida Pessoa on 22/07/24.
//

import SwiftUI

class ViewModelBase {
    var databaseManager: DataBaseManager 
    @Published var moviments: [Moviment] = []
    
    init(database: DataBaseManager) {
        databaseManager = database
        moviments = databaseManager.fetchMoviments()
    }
    
    func fetch() {
        moviments = databaseManager.fetchMoviments()
    }

    func addMoviment(value: Float, date: Date, receita: Bool, tag: TagEnum, desc: String) {
        if value != 0 {
            databaseManager.addMoviment(value: value, date: date, receita: receita, tag: tag, desc: desc)
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
        let entity = moviments[index]
        databaseManager.deleteMoviment(entity)
        saveData()
    }
    
    func saveData() {
        databaseManager.saveData()
        moviments = databaseManager.fetchMoviments()
    }
}



protocol Caio {
    var a: String { get }
}
extension Caio {
    func comerenroladoDeSalsicha() {
        print("caio")
    }
}

class Minino: Caio {
    var a: String = ""
}

class Gaybriael {
    var minino: Minino = Minino()
    func merendar() {
        minino.comerenroladoDeSalsicha()
    }
}

