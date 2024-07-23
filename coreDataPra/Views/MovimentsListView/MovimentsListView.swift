//
//  MovimentsListView.swift
//  coreDataPra
//
//  Created by Caio de Almeida Pessoa on 17/07/24.
//

import SwiftUI

struct MovimentsListView: View {
    var movimentPerDay: MovimentPerDay
    var dateMark: String
    var body: some View {
        List {
            Section {
                ForEach(movimentPerDay.moviment){ movi in
                    MovimentColabCell(moviment: movi, color: movi.valor >= 0 ? .green : .red)
                }
            } header: {
                HStack{
                    Text("Total: \(movimentPerDay.valor.twoDecimalPlaces)")
                        .font(.title3)
                    Spacer()
                    Text(dateMark)
                }
            }
        }
        .listRowSpacing(20)
    }
}

#Preview {
    MovimentsListView(movimentPerDay: .init(day: .now, moviment: FinancialMovimentViewModel(database: .init()).moviments, valor: 10.0), dateMark: "juny")
}
