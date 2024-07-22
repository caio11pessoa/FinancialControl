//
//  ListColabCell.swift
//  coreDataPra
//
//  Created by Caio de Almeida Pessoa on 17/07/24.
//

import SwiftUI


struct ListColabCell: View {
    var moviPerDay: MovimentPerDay
    
    var body: some View {
        HStack{        
            Text(moviPerDay.day.formatted(
                .dateTime
                    .month(.wide)
            ))
            Text("Ganho")
            Text("R$ " + moviPerDay.valor.twoDecimalPlaces)
                .foregroundStyle(.red)
        }
    }
}

#Preview {
    ListColabCell(moviPerDay: .init(day: .now, moviment: [], valor: 10.0))
}
