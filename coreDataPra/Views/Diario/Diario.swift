//
//  Diario.swift
//  coreDataPra
//
//  Created by Caio de Almeida Pessoa on 18/07/24.
//

import SwiftUI

struct Diario: View {
    @StateObject var viewModel: DiarioViewModel = DiarioViewModel()
    var body: some View {
        VStack(spacing: 0) {
            List {
                Section {
                    HStack{
                        Text("Total do mês")
                        Spacer()
                        Text("R$ \(viewModel.totalGastoMes.twoDecimalPlaces)")
                    }
                    HStack{
                        Text("Gasto diário previsto")
                        Spacer()
                        Text("R$ \(viewModel.gastoPrevisto.twoDecimalPlaces)")
                    }
                } header: {
                    HStack{
                        Text(returnMonth(monthString: viewModel.selectedMonth))
                        Spacer()
                        Picker("Mês", selection: $viewModel.selectedMonth){
                            ForEach(generateMonths(), id: \.self){ month in
                                Text(month)
                            }
                        }
                    }
                }
                Button {
                    
                } label: {
                    HStack{
                        Spacer()
                        Text("Nova Movimentação")
                        Spacer()
                    }
                }
            }
            .scrollDisabled(true)
            .frame(maxHeight: 240)
            List{
                Section {
                    if(viewModel.monthMoviments.isEmpty){
                        Text("Sem gastos")
                    }
                    ForEach(viewModel.dailyMoviments){ movi in
                        DiarioCell(date: movi.day, valor: (movi.valor == 0 ? movi.valor : -movi.valor).twoDecimalPlaces, color: viewModel.returnColor(val: movi.valor))
                    }
                }header: {
                    Text("Gastos")
                }
            }
        }
        .navigationTitle("Diário")
    }
}

#Preview {
    NavigationStack {
        Diario(viewModel: .init())
    }
}


struct MonthItem: Identifiable {
    
    let id: Int
    let name: String
    
    init(month: Int, calendar: Calendar = Calendar.current) {
        self.id = month
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM"
        if let date = calendar.date(bySetting: .month, value: month, of: Date()) {
            self.name = dateFormatter.string(from: date)
        } else {
            self.name = ""
        }
    }
}

private func returnMonth(monthString: String) -> String{
    let month = Calendar.current.date(bySetting: .month, value: Int(monthString)!, of: Date())
    return (month?.formatted(.dateTime
        .month(.wide)))!
}



private func generateMonths() -> [String] {
    
    return (1...12).map {
        if( $0 < 10){
            return "0\($0)"
        }
        return "\($0)"
    }
}


