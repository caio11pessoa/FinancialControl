//
//  AddMovimentSheet.swift
//  coreDataPra
//
//  Created by Caio de Almeida Pessoa on 15/07/24.
//

import SwiftUI
import Combine

struct AddMovimentSheet: View {
    @State var viewModel: FinancialMovimentViewModel
    
    var body: some View {
        NavigationStack {
            VStack {
                RoundedRectangle(cornerSize: CGSize(width: 10, height: 5))
//                    .foregroundStyle(.clear)
                    .frame(width: 190, height: 40)
                    .overlay {
                        TextField("New Value", text: $viewModel.newValue)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .keyboardType(.numberPad)
                            .onReceive(Just(viewModel.newValue)) { val in
                                let filtered = val.filter { "0123456789.".contains($0) }
                                if filtered != val {
                                    viewModel.newValue = filtered
                                }
                            }
                            .padding(.horizontal, 4)
                    }
                DatePicker("Data", selection: $viewModel.newDate)
                
                Button("Confirmar \(viewModel.receita ? "Receita" : "Gasto")") {
                    let incomeValue: Float = Float(viewModel.newValue) ?? 0
                    if(incomeValue != 0){
                        viewModel.addMoviment(value: incomeValue, date: viewModel.newDate, receita: viewModel.receita)
                        viewModel.newValue = ""
                        viewModel.isShowingSheet.toggle()
                    }
                }
                .padding()
            }
            .padding()
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button(action: {
                        viewModel.isShowingSheet.toggle()
                    }, label: {
                        Image(systemName: "xmark")
                            .font(.title3)
                    })
                }
                ToolbarItem(placement: .navigation) {
                    Text("Registrar")
                }
            }
        }
    }
}

#Preview {
    Text("text").sheet(isPresented: .constant(true)) {
        AddMovimentSheet(viewModel: FinancialMovimentViewModel())
    }
    
}
