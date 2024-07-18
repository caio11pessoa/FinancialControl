//
//  DashBoardCard.swift
//  coreDataPra
//
//  Created by Caio de Almeida Pessoa on 18/07/24.
//

import SwiftUI

struct DashBoardCard: View {
    var text: String
    var image: String
    var body: some View {
        VStack {
            ZStack{
                Color.blue.opacity(0.1)
                    .clipShape(RoundedRectangle(cornerRadius: 25))
                HStack{
                    
                    Image(systemName: image)
                        .font(.title)
                }
            }
            .frame(width: 80, height: 80)
            Text(text)
                .font(.title3)
        }
    }
}

#Preview {
    DashBoardCard(text: "Texto", image: "globe")
}
