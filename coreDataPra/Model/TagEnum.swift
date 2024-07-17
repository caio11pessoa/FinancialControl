//
//  TagEnum.swift
//  coreDataPra
//
//  Created by Caio de Almeida Pessoa on 16/07/24.
//

import Foundation

enum TagEnum: String, CaseIterable {
    case alimento = "Alimento"
    case trabalho = "Trabalho"
    case none = "Outros"
    case lazer = "Lazer"
    case aluguel = "Aluguel"
    
    func tapTag(_ tap: String) -> TagEnum {
        
        return TagEnum(rawValue: tap) ?? .none
    }
}

