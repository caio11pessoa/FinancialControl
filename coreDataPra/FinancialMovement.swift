//
//  FinancialMovement.swift
//  coreDataPra
//
//  Created by Caio de Almeida Pessoa on 11/07/24.
//

import SwiftUI
import Combine


struct FinancialMovement: View {
    @FetchRequest(sortDescriptors: []) var moviments: FetchedResults<Moviment>
    
    @Environment(\.managedObjectContext) var moc
    
    @State var isShowingSheet: Bool = false
    @State var newValue: String = ""
    @State var receita: Bool = false
    @State var newDate: Date = .now
    
    var total: Float {
        var currentValue: Float = 0
        for movi in moviments {
            currentValue += movi.valor
        }
        return currentValue
    }
    let formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()
    
    func dateFormated(from date: Date?) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let dateString = dateFormatter.string(from: date ?? .now)
        return dateString
    }
    
    func decimalCase(from number: Float) -> String {
        return String(format: "%.2f", number)
    }
    
    var movimentsSorted: [FetchedResults<Moviment>.Element] {
        moviments.sorted {
            if $0.date! > $1.date! {
                return true
            }
            return false
        }
    }
    
    
    var body: some View {
        VStack {
            HStack {
                Text("Total:")
                Text(decimalCase(from: total))
                    .foregroundStyle(total < 0 ? .red : .green)
            }
            List {
                ForEach(movimentsSorted){ moviment in
                    HStack{
                        Text(decimalCase(from: moviment.valor))
                        Spacer()
                        Text(dateFormated(from: moviment.date))
                    }
                }
                .onDelete { indexSet in
                    for index in indexSet {
                        let movimentToDelete = movimentsSorted[index]
                        moc.delete(movimentToDelete)
                        try! moc.save()
                    }
                }
            }
            HStack {
                Button("Receita") {
                    receita = true
                    isShowingSheet.toggle()
                }
                .padding()
                
                Button("Gasto"){
                    receita = false
                    isShowingSheet.toggle()
                }
                .tint(.red)
                .padding()
            }
            .padding()
            .sheet(isPresented: $isShowingSheet){
                NavigationStack {
                    VStack {
                        RoundedRectangle(cornerSize: CGSize(width: 10, height: 10))
                            .frame(width: 200, height: 40)
                            .overlay {
                                TextField("New Value", text: $newValue)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .keyboardType(.numberPad)
                                    .onReceive(Just(newValue)) { val in
                                        let filtered = val.filter { "0123456789.".contains($0) }
                                        if filtered != val {
                                            self.newValue = filtered
                                        }
                                    }
                                    .padding(.horizontal, 8)
                            }
                        DatePicker("Data", selection: $newDate)
                        
                        Button("Confirmar \(receita ? "Receita" : "Gasto")") {
                            let incomeValue: Float = Float(newValue) ?? 0
                            if(incomeValue != 0){
                                let moviment = Moviment(context: moc)
                                moviment.id = UUID()
                                moviment.valor = receita ? incomeValue : -incomeValue
                                moviment.date = newDate
                                try? moc.save()
                            }
                            newValue = ""
                            isShowingSheet.toggle()
                        }
                        .padding()
                    }
                    .padding()
                    .toolbar {
                        ToolbarItem(placement: .primaryAction) {
                            Button(action: {
                                isShowingSheet.toggle()
                            }, label: {
                                Image(systemName: "arrow.uturn.down")
                                    .font(.title3)
                            })
                        }
                        ToolbarItem(placement: .navigation) {
                            Text("Registrar")
                        }
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    NavigationLink {
                        Graficos()
                    } label: {
                        Text("Graficos")
                    }
                    
                }
            }
        }
    }
}

#Preview {
    NavigationStack{
        FinancialMovement()
            .environment(\.managedObjectContext, DataController().container.viewContext)
    }
}

extension Float {
    /// Rounds the double to decimal places value
    func rounded(toPlaces places:Int) -> Float {
        let divisor = pow(10.0, Float(places))
        return (self * divisor).rounded() / divisor
    }
}
