//
//  MovimentPerDay.swift
//  coreDataPra
//
//  Created by Caio de Almeida Pessoa on 22/07/24.
//

import Foundation

struct MovimentPerDay: Identifiable{
    var day: Date
    var moviment: [Moviment]
    var valor: Float
    var id: Date {day}
}
