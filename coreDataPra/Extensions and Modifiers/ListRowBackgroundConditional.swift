//
//  ListRowBackgroundConditional.swift
//  coreDataPra
//
//  Created by Caio de Almeida Pessoa on 23/07/24.
//

import SwiftUI

extension View {
    func listRowBackground(condition: Bool) -> some View {
        Group {
            if(condition) {
                self.listRowBackground(Color.gray.opacity(0.2))
            }else {
                self
            }
        }
    }}
