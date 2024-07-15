//
//  FinancialMovement.swift
//  coreDataPra
//
//  Created by Caio de Almeida Pessoa on 11/07/24.
//

import SwiftUI

struct FinancialMovement: View {
    
    @StateObject var viewModel: FinancialMovimentViewModel = FinancialMovimentViewModel()
    
    var body: some View {
        VStack {
            List {
                Section {
                    ForEach(viewModel.sorted ? viewModel.movimentsSorted : viewModel.moviments){ moviment in
                        HStack{
                            Text(moviment.valor.decimalPlaces(2))
                            Spacer()
                            Text(
                                moviment.date?.formatted(
                                    .dateTime
                                        .day()
                                        .month(.twoDigits)
                                        .hour()
                                        .minute()
                                ) ?? Date.now.formatted(
                                    .dateTime
                                        .day()
                                        .month(.twoDigits)
                                        .hour()
                                        .minute()
                                )
                            )
                        }
                    }
                    .onDelete(perform: viewModel.deleteMoviment)
                } header: {
                    
                    HStack {
                        Text("Total:")
                        Text(viewModel.total.twoDecimalPlaces)
                            .foregroundStyle(viewModel.total < 0 ? .red : .green)
                    }
                }
            }
            HStack {
                Button("Receita") {
                    viewModel.receita = true
                    viewModel.isShowingSheet.toggle()
                }
                .padding()
                
                Button("Gasto"){
                    viewModel.receita = false
                    viewModel.isShowingSheet.toggle()
                }
                .tint(.red)
                .padding()
            }
            .padding()
            .sheet(isPresented: $viewModel.isShowingSheet){
                AddMovimentSheet(viewModel: viewModel)
            }
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    NavigationLink {
                        Graficos()
                    } label: {
                        Text("Graficos")
                    }
                    
                }
                ToolbarItem {
                    Menu {
                        buttonSorted
                    } label: {
                        Text("Tipos de ordenação")
                    }
                    
                    
                }
            }
        }
    }
    
    var buttonSorted: some View {
        Button {
            withAnimation {
                viewModel.sorted.toggle()
            }
        } label: {
            HStack{
                Text("Data")
                if(viewModel.sorted){
                    Image(systemName: "checkmark")
                }
            }
        }
    }
}

#Preview {
    NavigationStack{
        FinancialMovement()
    }
}
