//
//  MovimentColabCell.swift
//  coreDataPra
//
//  Created by Caio de Almeida Pessoa on 21/07/24.
//

import SwiftUI

struct MovimentColabCell: View {
    var moviment: Moviment
    var color: Color
    var body: some View {
        VStack {
            HStack{
                Text(moviment.date?.FormattedDayDate ?? "")
                Spacer()
                Text(moviment.tag ?? "Outros")
                    .multilineTextAlignment(.leading)
                    .foregroundStyle(.black.opacity(0.5))
                Spacer()
                Text("R$ \(moviment.valor.twoDecimalPlaces)")
                    .foregroundStyle(color)
                    .bold()
            }
            HStack{
                Text(moviment.descricao ?? "Sem descrição")
                    .foregroundStyle(.black.opacity(0.5))
            }
            .padding()
        }
    }
}

#Preview {
    MovimentColabCell(moviment: FinancialMovimentViewModel(database: .init()).moviments.first!,  color: .green)
}
