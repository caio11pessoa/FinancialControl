//
//  DiarioCell.swift
//  coreDataPra
//
//  Created by Caio de Almeida Pessoa on 19/07/24.
//

import SwiftUI

struct DiarioCell: View {
    var date: Date
    var valor: String
    var color: Color
    var body: some View {
        HStack{
            Text(date.FormattedDayDate)
            Spacer()
            Text("R$ \(valor)")
                .foregroundStyle(color)
            Image(systemName: "arrow.up")
        }
    }
}

#Preview {
    DiarioCell(date: .now, valor: "1.000,00", color: .green
    )
}
