//
//  AddMoviment.swift
//  coreDataPra
//
//  Created by Caio de Almeida Pessoa on 21/07/24.
//

import SwiftUI
import Combine

// Usando o conceito de callback
struct AddMoviment: View {
    @State var newValue: String = ""
    @State var tagSelected: TagEnum = .none
    @State var newDate: Date = .now
    @State var newDescription: String = ""
    @State private var selected: String = "Gasto"
    private let selectionOptions = [
        "Gasto",
        "Receita",
    ]
    var receita: Bool {selected == "Receita"}
    var callback: (
        _ newValue: String,
        _ tagSelected: TagEnum,
        _ newDate: Date,
        _ newDescription: String,
        _ receita: Bool
    ) -> ()
    var body: some View {
        ZStack {
            Color(.backgroundForm).ignoresSafeArea()
            VStack(alignment: .center) {
                Text("Registrar Movimentação")
                    .font(.title3)
                    .padding()
                Form {
                    Picker("Picker Name",
                           selection: $selected) {
                        ForEach(selectionOptions,
                                id: \.self) {
                            Text($0)
                        }
                    }
                           .pickerStyle(.segmented)
                    HStack {
                        Text("Valor: ")
                        TextField("R$", text: $newValue)
                            .onReceive(Just(newValue)) { val in
                                let filtered = val.filter { "0123456789.".contains($0) }
                                if filtered != val {
                                    newValue = filtered
                                }
                            }
                    }
                    
                    Picker("Tipo:", selection: $tagSelected) {
                        ForEach(TagEnum.allCases, id: \.self){ tag in
                            Text(tag.rawValue)
                        }
                    }
                    DatePicker("Data", selection: $newDate)
                    HStack {
                        Text("Descrição: ")
                        TextField("Nenhuma descrição", text: $newDescription)
                    }
                    HStack{
                        Spacer()
                        Button("Confirmar \(selected)") {
                            callback(newValue, tagSelected, newDate, newDescription, receita)
                        }
                        Spacer()
                    }
                }
            }
            .padding()
        }
    }
}

#Preview {
    AddMoviment(callback: { newValue, tagSelected, newDate, newDescription, receita in
        
    })
}
