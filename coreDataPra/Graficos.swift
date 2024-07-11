//
//  Graficos.swift
//  coreDataPra
//
//  Created by Caio de Almeida Pessoa on 11/07/24.
//

import SwiftUI
import Charts

struct Graficos: View {
    
    @FetchRequest(sortDescriptors: []) var moviments: FetchedResults<Moviment>
    
    
    func decimalCase(from number: Float) -> String {
        return String(format: "%.2f", number)
    }
    
    func dateFormated(from date: Date?) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yy-MMM-dd"
        let dateString = dateFormatter.string(from: date ?? .now)
        return dateString
    }
    
    var receitas: [Moviment] {
        var gast: [Moviment] = []
        for movi in moviments {
            if(movi.valor >= 0){
                gast.append(movi)
            }
        }
        return gast
    }

    var gastos: [Moviment] {
        var gast: [Moviment] = []
        for movi in moviments {
            if(movi.valor < 0){
                gast.append(movi)
            }
        }
        return gast
    }
    
    
    var body: some View {
        TabView {
            gastosPorMes
                .tabItem {
                    Label("Mes", systemImage: "list.dash")
                }
            comparacaoReceitasEGastos
                .tabItem {
                    Label("comparative", systemImage: "list.dash")
                }
            porSemana
                .tabItem {
                    Label("semana", systemImage: "list.dash")
                }
            porSemana
                .tabItem {
                    Label("semana", systemImage: "list.dash")
                }
            porSemana
                .tabItem {
                    Label("semana", systemImage: "list.dash")
                }
        }
    }
    var gastosPorMes2: some View {
        Chart {
            BarMark(x: .value("name", "cachapa"), y: .value("Sales", 916))
            BarMark(x: .value("Name", "Injera"), y: .value("Sales", 850))
        }
    }
    
    var gastosPorMes: some View {
        Chart(moviments) { movi in
            BarMark(x: .value("data", dateFormated(from: movi.date)), y: .value("Movimentação", decimalCase(from:movi.valor)))
        }
    }
    
    
//    var datasComparative: []
    
    var comparacaoReceitasEGastos: some View {
        Chart{
//            LineMark{
//                
//            }
        }
    }
    
    let sales: [Pancakes] = [
        .init(name: "Cachapa", sales: 916),
        .init(name: "Injera", sales: 850),
        .init(name: "Crepe", sales: 802)
    ]
    var porSemana: some View {
        Chart(sales){ element in
            BarMark(x: .value("Name", element.name), y: .value("Sales", element.sales))
        }
    }
    
    
    
    let seriesData: [Series] = [
        .init(city: "Cupertino", sales: cupertinoData),
        .init(city: "San Francisco", sales: sfData)
    ]
}

struct Pancakes: Identifiable {
    let name: String
    let sales: Int
    
    var id: String { name }
}
struct SalesSummary: Identifiable {
    let weekday: Date
    let sales: Int
    
    var id: Date { weekday }
}
var sfData: [SalesSummary] = [
    .init(weekday: .now, sales: 81),
    .init(weekday: .now, sales: 90),
    .init(weekday: .now, sales: 52),
    .init(weekday: .now, sales: 72),
    .init(weekday: .now, sales: 84),
    .init(weekday: .now, sales: 137)
]
let cupertinoData: [SalesSummary] = [
    .init(weekday: .now, sales: 54),
    .init(weekday: .now, sales: 42),
    .init(weekday: .now, sales: 88),
    .init(weekday: .now, sales: 49),
    .init(weekday: .now, sales: 42),
    .init(weekday: .now, sales: 125),
    .init(weekday: .now, sales: 67)
]

struct Series: Identifiable {
    let city: String
    let sales: [SalesSummary]
    var id: String { city}
}
#Preview {
    Graficos()
}
