//
//  MovimentosPorPeriodo.swift
//  coreDataPra
//
//  Created by Caio de Almeida Pessoa on 21/07/24.
//

import SwiftUI

struct MovimentosPorPeriodo: View {
    var movimentPerDay: MovimentPerDay
    var dateMark: String
    var date: Date
    @State var isPresented: Bool = false
    var callback: (
        _ newValue: String,
        _ tagSelected: TagEnum,
        _ newDate: Date,
        _ newDescription: String,
        _ receita: Bool,
        _ isPresented: inout Bool
    ) -> ()
    var body: some View {
        List {
            Button {
                isPresented = true
            } label: {
                HStack {
                    Spacer()
                    Text("Nova Movimentação")
                    Spacer()
                }
            }
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
        .sheet(isPresented: $isPresented, content: {
            AddMoviment(newDate: date, isPresented: $isPresented, callback: callback)
        })
        
    }
}

#Preview {
    MovimentosPorPeriodo(movimentPerDay: .init(day: .now, moviment: [], valor: 0), dateMark: "10/10", date: .now) { newValue, tagSelected, newDate, newDescription, receita, isPresented  in
        
    }
}
