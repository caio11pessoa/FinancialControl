//
//  PerfilView.swift
//  coreDataPra
//
//  Created by Caio de Almeida Pessoa on 23/07/24.
//

import SwiftUI

enum colors: String, CaseIterable {
    case red
}

struct PerfilView: View {
    @State private var bgColor = Color.red
    @State private var secondColor = Color.blue
    var raw: Int {
//        var newColor = bgColor.description
        
//        print(newColor)
        return bgColor.hashValue
    }

    var body: some View {
        VStack{
            Text(String(raw))
                .background(secondColor)
//            Text(String(raw))
//            Form {
                ColorPicker("Set the background color", selection: $bgColor)
//            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(bgColor)
        }
        .onChange(of: bgColor) {
            let thirdColor = bgColor
            guard let components = thirdColor.cgColor?.components else {
                return
            }
            let red = components[0]
            let green = components[1]
            let blue = components[2]
            let alpha = components[3]

            secondColor = Color(red: Double(red), green: Double(green), blue: Double(blue), opacity: Double(alpha))
        }
    }
}

#Preview {
    PerfilView()
}
