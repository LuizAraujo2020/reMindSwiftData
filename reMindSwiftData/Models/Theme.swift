//
//  Theme.swift
//  reMindSwiftData
//
//  Created by Luiz Araujo on 08/03/24.
//

import SwiftUI

enum reTheme: Int, CaseIterable {
    case aquamarine = 0
    case mauve
    case lavender

    var name: String {
        switch self {
        case .aquamarine:
            return "aquamarine"
        case .mauve:
            return "mauve"
        case .lavender:
            return "lavender"
        }
    }

    var render: Color {
        Color(self.name)
    }
}
