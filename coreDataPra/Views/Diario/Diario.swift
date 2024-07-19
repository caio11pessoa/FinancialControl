//
//  Diario.swift
//  coreDataPra
//
//  Created by Caio de Almeida Pessoa on 18/07/24.
//

import SwiftUI

struct Diario: View {
    var body: some View {
        List {
            Section {
                HStack{
                    Text("Total do mês")
                    Spacer()
                    Text("R$ 10.000")
                }
                HStack{
                    Text("Gasto diário previsto")
                    Spacer()
                    Text("R$ 750")
                }
            }
            Section {
                HStack{
                    Text("01/11/22")
                    Spacer()
                    Text("R$ 1.000,00")
                    Image(systemName: "arrow.up")
                }
                HStack {
                    Text("02/11/22")
                    Spacer()
                    Text("R$ 500,00")
                    Image(systemName: "arrow.down")
                }
                HStack {
                    Text("03/11/22")
                    Spacer()
                    Text("R$ 1.000,00")
                    Image(systemName: "arrow.up")
                }
                HStack {
                    Text("03/11/22")
                    Spacer()
                    Text("R$ 1.000,00")
                    Image(systemName: "arrow.up")
                }
            } header: {
                Text("Janeiro")
            }
//            Section {
//            HStack {
//                    Spacer()
//                    Button("Novo Gasto") {
//                        print("kasksak")
//                    }
            Button {
                
            } label: {
                HStack{
                    Spacer()
                    Text("Novo Gasto") 
                    Spacer()
                }
            }

//                    Spacer()
//                }
//            }

            
        }
    }
}

#Preview {
    Diario()
}
