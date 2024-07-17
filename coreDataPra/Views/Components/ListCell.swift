//
//  ListCell.swift
//  coreDataPra
//
//  Created by Caio de Almeida Pessoa on 16/07/24.
//

import SwiftUI

struct ListCell: View {
    var moviment: Moviment
    var body: some View {
        HStack{
            Text("R$ " + moviment.valor.decimalPlaces(2))
                .foregroundStyle(moviment.valor >= 0 ? .green : .red)
                .frame(width: 100, alignment: .leading)
            Spacer()
            Text(moviment.tag ?? "Outros")
                .multilineTextAlignment(.leading)
                .foregroundStyle(.black.opacity(0.5))
            Spacer()
            Text(
                moviment.date?.formatted(
                    .dateTime
                        .day(.twoDigits)
                        .month(.twoDigits)
                        .hour()
                        .minute()
                ) ?? Date.now.formatted(
                    .dateTime
                        .day()
                        .month(.twoDigits)
                        .hour()
                        .minute()
                )
            )
        }
    }
}

#Preview {
    ListCell(moviment: FinancialMovimentViewModel().moviments.first!)
}
