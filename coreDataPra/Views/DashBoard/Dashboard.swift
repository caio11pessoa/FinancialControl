//
//  Dashboard.swift
//  coreDataPra
//
//  Created by Caio de Almeida Pessoa on 18/07/24.
//

import SwiftUI

struct Dashboard: View {
    @StateObject var viewModel: FinancialMovimentViewModel = FinancialMovimentViewModel()
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                Text("Saldo atual")
                    .font(.title3)
                    .padding(.bottom)
                Text("R$ 1.000,00")
                    .font(.title)
                    .bold()
                Divider()
                    .background(.black)
            }
            .padding(.horizontal)
            ScrollView(.horizontal) {
                LazyHGrid(rows: [
                    GridItem(.flexible()),
                ], spacing: 20) {
                    NavigationLink {
                        Graficos(viewModel: FinancialMovimentViewModel())
                    } label: {
                        DashBoardCard(text: "Gráfico")
                    }
                    NavigationLink {
                        FinancialMovement(viewModel: viewModel)
                    } label: {
                        DashBoardCard(text: "estrato")
                    }
                    NavigationLink {
                        
                    } label: {
                        DashBoardCard(text: "Perfil")
                    }
                    NavigationLink {
                        
                    } label: {
                        DashBoardCard(text: "algo")
                    }
                    NavigationLink {
                        
                    } label: {
                        DashBoardCard(text: "Gráfico")
                    }
                    NavigationLink {
                        
                    } label: {
                        DashBoardCard(text: "Gráfico")
                    }
                }
                .padding(8)
            }
            .frame(height: 120)
            Text("Gráfico de montante por dia no mês")
            Spacer()
        }
        .navigationTitle("Dashboard")
    }
}

#Preview {
    NavigationStack{
        Dashboard()
    }
}
