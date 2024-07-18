//
//  MovimentColabView.swift
//  coreDataPra
//
//  Created by Caio de Almeida Pessoa on 17/07/24.
//

import SwiftUI

struct MovimentColabView: View {
    var movimentPerDay: FinancialMovimentViewModel.MovimentPerDay
    var dateMark: String
    var body: some View {
        List {
            Section {
                ForEach(movimentPerDay.moviment){ movi in
                    VStack(alignment: .leading) {
                        HStack{
                            Spacer()
                            Text("Gasto: \(movi.tag ?? "Outros")")
                            Spacer()
                        }
                        Spacer()
                        HStack{
                            Text("Valor:")
                            Text(movi.valor.twoDecimalPlaces)
                                .foregroundStyle(movi.valor < 0 ? .red : .green)
                        }
                        Spacer()
                        Text(movi.descricao ?? "Nenhuma descrição")
                        Spacer()
                    }
                    .frame(height: 200)
                }
            } header: {
                HStack{
                    Text("Total: \(movimentPerDay.valor)")
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
    MovimentColabView(movimentPerDay: .init(day: .now, moviment: FinancialMovimentViewModel().moviments, valor: 10.0), dateMark: "juny")
}
