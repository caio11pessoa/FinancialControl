//
//  ContentView.swift
//  coreDataPra
//
//  Created by Caio de Almeida Pessoa on 10/07/24.
//

import SwiftUI

struct ContentView: View {
    @FetchRequest(sortDescriptors: []) var students: FetchedResults<Student>
    
    @Environment(\.managedObjectContext) var moc
    
    var body: some View {
        NavigationStack{
            VStack {
                List(students) { student in
                    Text(student.name ?? "Unknown")
                }
                Button("Add") {
                    let firstNames = ["Ginny", "Harry", "Hermione", "Luna", "Ron"]
                    let lastNames = ["Granger", "Lovegood", "Potter", "Weasley"]
                    
                    let chosenFirstName = firstNames.randomElement()!
                    let chosenLastName = lastNames.randomElement()!
                    
                    let student = Student(context: moc)
                    student.id = UUID()
                    student.name = "\(chosenFirstName) Cleber \(chosenLastName)"
                    
                    try? moc.save()
                }
            }
            .toolbar(content: {
                ToolbarItem(placement: .primaryAction) {
                    NavigationLink {
                        FinancialMovement()
                    } label: {
                        Text("Controle Financeiro")
                    }

                }
            })
        }
    }
}

#Preview {
    ContentView()
        .environment(\.managedObjectContext, DataController().container.viewContext)
}
