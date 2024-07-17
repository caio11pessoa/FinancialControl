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
    @State var tagSelected: TagEnum = .none
    
    init(viewModel: FinancialMovimentViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
//                    .frame(width: 110)
                }
                RoundedRectangle(cornerSize: CGSize(width: 10, height: 5))
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
                HStack{
                    Text("Tipo:")
                    Spacer()
                    Picker("Qual tipo de movimentação", selection: $tagSelected) {
                        ForEach(TagEnum.allCases, id: \.self){ tag in
                            Text(tag.rawValue)
                        }
                    }
                    Spacer()
                }
                DatePicker("Data", selection: $viewModel.newDate)
                
                Button("Confirmar \(viewModel.receita ? "Receita" : "Gasto")") {
                    let incomeValue: Float = Float(viewModel.newValue) ?? 0
                    if(incomeValue != 0){
                        viewModel.addMoviment(value: incomeValue, date: viewModel.newDate, receita: viewModel.receita, tag: tagSelected)
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
