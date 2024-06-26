//
//  reTextFieldStyle.swift
//  reMind
//
//  Created by Luiz Araujo on 24/02/24.
//

import SwiftUI

struct reTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .frame(height: 42)
            .padding(.horizontal, 8)
            .background(Palette.background.render)
            .cornerRadius(10)
            .shadow(color: .black.opacity(0.25), radius: 10)
    }
}
