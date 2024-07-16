//
//  Graficos.swift
//  coreDataPra
//
//  Created by Caio de Almeida Pessoa on 11/07/24.
//

import SwiftUI
import Charts

struct Graficos: View {
    @StateObject var viewModel: FinancialMovimentViewModel
    
    var body: some View {
        VStack {
            if(viewModel.moviments.isEmpty){
                Text("Sem Movimentações")
            } else {
                if viewModel.isLines {
                    lines
                } else {
                    columns
                }
            }
        }
        .toolbar(content: {
            ToolbarItem(placement: .primaryAction) {
                Menu {
                    Button("Linhas") {
                        viewModel.isLines = true
                    }
                    Button("Colunas") {
                        viewModel.isLines = false
                    }
                } label: {
                    Text("Tipo de gráfico")
                }
                
            }
        })
    }
    
    var lines: some View {
        VStack{
            TabView {
                Chart(viewModel.ganhosPorDia){ ganhos in
                    LineMark(x: .value("Day", ganhos.day), y: .value("Ganhos", ganhos.valor))
                }.tabItem {
                    Text("Ganhos")
                }
                
                Chart(viewModel.gastosPorDia){ gastos in
                    LineMark(x: .value("Day", gastos.day), y: .value("Gastos", -gastos.valor))
                        .foregroundStyle(.red)
                }.tabItem {
                    Text("Gastos")
                }
            }
        }
    }
    
    var columns: some View {
        TabView {
            Chart(viewModel.ganhosPorDia){ element in
                BarMark(x: .value("date", element.day.formatted(
                    .dateTime
                        .day()
                        .month(.twoDigits)
                        .hour()
                        .minute()
                )), y: .value("Ganhos", element.valor))
            }.tabItem {
                Text("Ganhos")
            }
            
            Chart(viewModel.gastosPorDia){ element in
                BarMark(x: .value("date", element.day.formatted(
                    .dateTime
                        .day()
                        .month(.twoDigits)
                        .hour()
                        .minute()
                )), y: .value("Gastos", -element.valor))
                .foregroundStyle(.red)
            }.tabItem {
                Text("Gastos")
            }
        }
        
    }
}

#Preview {
    NavigationStack{
        Graficos(viewModel: FinancialMovimentViewModel())
    }
}
