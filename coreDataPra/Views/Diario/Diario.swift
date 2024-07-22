//
//  Diario.swift
//  coreDataPra
//
//  Created by Caio de Almeida Pessoa on 18/07/24.
//

import SwiftUI

struct Diario: View {
    @StateObject var viewModel: DiarioViewModel = DiarioViewModel()
    @State var isPresented: Bool = false
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
                    isPresented = true
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
                        NavigationLink {
                            MovimentosPorPeriodo(movimentPerDay: movi, dateMark: movi.day.FormattedDayDate, date: movi.day) { newValue, tagSelected, newDate, newDescription, receita in
                                viewModel.addMoviment(value: Float(newValue)!, date: newDate, receita: receita, tag: tagSelected, desc: newDescription)
                            }
                        } label: {
                            DiarioCell(date: movi.day, valor: (movi.valor == 0 ? movi.valor : -movi.valor).twoDecimalPlaces, color: viewModel.returnColor(val: -movi.valor))
                        }

                    }
                }header: {
                    Text("Gastos")
                }
            }
        }
        .navigationTitle("Diário")
        .sheet(isPresented: $isPresented, content: {
            AddMoviment { newValue, tagSelected, newDate, newDescription, receita in
                if let value = Float(newValue) {
                    viewModel.addMoviment(value: value, date: newDate, receita: receita, tag: tagSelected, desc: newDescription)
                    isPresented = false
                }
            }
        })
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


