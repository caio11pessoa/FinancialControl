//
//  FinancialMovimentViewModel.swift
//  coreDataPra
//
//  Created by Caio de Almeida Pessoa on 11/07/24.
//

import SwiftUI

class FinancialMovimentViewModel: ObservableObject {
    @FetchRequest(sortDescriptors: []) var students2: FetchedResults<Student>
    @FetchRequest(sortDescriptors: []) var moviments2: FetchedResults<Moviment>

}

