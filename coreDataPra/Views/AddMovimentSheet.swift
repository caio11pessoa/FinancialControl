//
//  AddMovimentSheet.swift
//  coreDataPra
//
//  Created by Caio de Almeida Pessoa on 15/07/24.
//

import SwiftUI
import Combine

struct AddMovimentSheet: View {
    @StateObject var viewModel: FinancialMovimentViewModel
    @State var tagSelected: TagEnum = .none
    
    var body: some View {
        ZStack {
            Color(.backgroundForm).ignoresSafeArea()
            VStack(alignment: .center) {
                Text("Registrar Movimentação")
                    .font(.title3)
                    .padding()
                Form {
                    HStack {
                        Text("Valor: ")
                        TextField("R$", text: $viewModel.newValue)
                            .onReceive(Just(viewModel.newValue)) { val in
                                let filtered = val.filter { "0123456789.".contains($0) }
                                if filtered != val {
                                    viewModel.newValue = filtered
                                }
                            }
                    }
                    
                    Picker("Tipo:", selection: $tagSelected) {
                        ForEach(TagEnum.allCases, id: \.self){ tag in
                            Text(tag.rawValue)
                        }
                    }
                    DatePicker("Data", selection: $viewModel.newDate)
                    HStack {
                        Text("Descrição: ")
                        TextField("Nenhuma descrição", text: $viewModel.newDescription)
                    }
                    Button("Confirmar \(viewModel.receita ? "Receita" : "Gasto")") {
                        
                        let incomeValue: Float = Float(viewModel.newValue) ?? 0
                        if(incomeValue != 0){
                            viewModel.addMoviment(value: incomeValue, date: viewModel.newDate, receita: viewModel.receita, tag: tagSelected, desc: viewModel.newDescription)
                            viewModel.newValue = ""
                            viewModel.isShowingSheet.toggle()
                        }
                    }
                }
            }
            .padding()
        }
    }
}

#Preview {
    Text("text").sheet(isPresented: .constant(true)) {
        AddMovimentSheet(viewModel: FinancialMovimentViewModel())
    }
    
}
