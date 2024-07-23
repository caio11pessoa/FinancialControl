//
//  MovimentView.swift
//  coreDataPra
//
//  Created by Caio de Almeida Pessoa on 16/07/24.
//

import SwiftUI

struct MovimentView: View {
    var moviment: Moviment
    var body: some View {
        VStack {
            Form {
                Section {
                    HStack{
                        Text("Valor:")
                        Spacer()
                        Text("R$\(moviment.valor.twoDecimalPlaces)")
                            .foregroundStyle(moviment.valor >= 0 ? .green : .red)
                    }
                    HStack {
                        Text("Tipo:")
                        Spacer()
                        Text("\(moviment.tag ?? "Outros")")
                            .foregroundStyle(.gray)
                    }
                    
                    HStack {
                        Text("Data:")
                        Spacer()
                        Text("\(moviment.date!.formatted(.dateTime.day(.twoDigits).month(.twoDigits).year()))")
                            .foregroundStyle(.gray)
                    }
                    
                    HStack {
                        Text("Descrição:")
                        Spacer()
                        Text(moviment.descricao ?? "Nenhuma descrição")
                            .foregroundStyle(.gray)
                    }
                } header: {
                    HStack{
                        Text("Movimentação")
                            .font(.title3)
                            .bold()
                        Spacer()
                        Button(action: {
                            
                        }, label: {
                            Text("Editar")
                                .font(.title3)
                                .bold()
                        })
                    }
                }
            }
        }
    }
}

#Preview {
    MovimentView(moviment: FinancialMovimentViewModel(database: .init()).moviments.first!)
}
