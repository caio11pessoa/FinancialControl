//
//  DataController.swift
//  coreDataPra
//
//  Created by Caio de Almeida Pessoa on 10/07/24.
//

import CoreData

class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "Bookworm")
    
    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Core Data failed to load: \(error.localizedDescription)")
            }
        }
    }
}
