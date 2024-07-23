//
//  AppStorageManager.swift
//  coreDataPra
//
//  Created by Caio de Almeida Pessoa on 22/07/24.
//

import SwiftUI

class AppStorageManager: ObservableObject {
    @AppStorage("expectedSaving") static private var _expectedSaving: Double = 0
    @AppStorage("appColor") static private var _color: String = ""
    static var expectedSaving: String {
        get {
            return String(_expectedSaving)
        }
        set(newVal) {
            if let val = Double(newVal) {
                _expectedSaving = val
            }
        }
    }
    static var color: String {
        get {
            return String(_color)
        }
        set(newVal) {
            if let val = Double(newVal) {
                _expectedSaving = val
            }
        }
    }
    
}
