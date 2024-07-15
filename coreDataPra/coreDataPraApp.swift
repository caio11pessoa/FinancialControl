//
//  coreDataPraApp.swift
//  coreDataPra
//
//  Created by Caio de Almeida Pessoa on 10/07/24.
//

import SwiftUI

@main
struct coreDataPraApp: App {
    @StateObject private var dataController = DataController()
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                FinancialMovement()
            }
        }
    }
}
