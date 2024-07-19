//
//  DateExtension.swift
//  coreDataPra
//
//  Created by Caio de Almeida Pessoa on 18/07/24.
//

import SwiftUI

extension Date {
    var FormattedfullDate: String {
        self.formatted(
            .dateTime
                .day(.twoDigits)
                .month(.twoDigits)
                .hour()
                .minute()
        )
    }
    var FormattedDayDate: String {
        self.formatted(
            .dateTime
                .day(.twoDigits)
                .month(.twoDigits)
                .year(.twoDigits)
        )
    }
}


