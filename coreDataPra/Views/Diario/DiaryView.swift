//
//  Diario.swift
//  coreDataPra
//
//  Created by Caio de Almeida Pessoa on 18/07/24.
//

import SwiftUI

struct DiaryView: View {
    @StateObject var viewModel: DiaryViewModel = DiaryViewModel(database: .init())
    
    @State var isPresented: Bool = false
    @State var text: String = ""
    @State var onFocus: Bool = false
    
    var body: some View {
        VStack(spacing: 0) {
            List {
                Section {
                    HStack{
                        Text("Total do mês")
                        Spacer()
                        Text("R$ \(viewModel.totalGastoMes.twoDecimalPlaces)")
                    }
                    if(viewModel.isCurrentMonth){
                        HStack{
                            Text("Gasto diário previsto")
                            Spacer()
                            Text("R$ \(viewModel.gastoPrevisto.twoDecimalPlaces)")
                        }
                        HStack {
                            if(onFocus) {
                                TextField("Economia Prevista", text: $text, prompt: Text(AppStorageManager.expectedSaving))
                                Button("Save") {
                                    onFocus = false
                                    AppStorageManager.expectedSaving = text
                                    text = ""
                                }
                            } else {
                                Text("Ecoomia previsto")
                                Spacer()
                                Text("R$ \(AppStorageManager.expectedSaving)")
                                    .foregroundStyle(.black.opacity(0.5))
                                    .onTapGesture {
                                        onFocus = true
                                    }
                            }
                        }
                    }else {
                        HStack{
                            Text("Economia")
                            Spacer()
                            Text("R$ Mockado")
                        }
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
            .frame(maxHeight: 280)
            ScrollViewReader { proxy in
                List {
                    Section {
                        if(viewModel.monthMoviments.isEmpty){
                            Text("Sem gastos")
                        }
                        ForEach(viewModel.dailyMoviments){ movi in
                            NavigationLink {
                                MovimentosPorPeriodo(
                                    movimentPerDay: movi,
                                    dateMark: movi.day.FormattedDayDate,
                                    date: movi.day,
                                    callback: callBack
                                )
                            } label: {
                                DiaryCell(
                                    date: movi.day,
                                    valor: (movi.valor == 0 ? movi.valor : -movi.valor).twoDecimalPlaces,
                                    color: viewModel.returnColor(val: -movi.valor))
                            }
                            .listRowBackground(
                                condition: movi.day.formatted( .dateTime.day().month())
                                == Date.now.formatted(.dateTime.day().month())
                            )
                        }
                    }header: {
                        Text("Gastos")
                    }
                }
                .onAppear(perform: {
                    let id = (Int(Date.now.formatted(.dateTime.day()))! - 1)
                    proxy.scrollTo(viewModel.dailyMoviments[id].id, anchor: .center)
                })
            }
        }
        .navigationTitle("Diário")
        .sheet(isPresented: $isPresented, content: {
            AddMoviment(
                isPresented: $isPresented,
                callback: callBack
            )
        })
    }
    
    func callBack(
        _ newValue: String,
        _ tagSelected: TagEnum,
        _ newDate: Date,
        _ newDescription: String,
        _ receita: Bool,
        _ isPresented: inout Bool
    ) {
        if let value = Float(newValue) {
            viewModel.addMoviment(value: value, date: newDate, receita: receita, tag: tagSelected, desc: newDescription)
            isPresented = false
        }
    }
}

#Preview {
    NavigationStack {
        DiaryView(viewModel: .init(database: .init()))
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


