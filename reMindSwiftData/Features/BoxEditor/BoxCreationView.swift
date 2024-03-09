//
//  BoxCreationVIew.swift
//  reMind
//
//  Created by Luiz Araujo on 27/02/24.
//

import SwiftUI

struct BoxCreationView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) private var modelContext

//    @State private var box = Box.createEmpty()
    @State private var name = ""
    @State private var keywords = ""
    @State private var descriptions = ""
    @State private var rawTheme = 0


    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                reTextField(
                    text: $name,
                    title: "Name"
                )

                reTextField(
                    text: $keywords,
                    title: "Keywords",
                    caption: "Separated by , (comma)"
                )

                reTextEditor(text: $descriptions, title: "Description")

                reRadionButtonGroup(currentSelection: $rawTheme, title: "Theme")

                Spacer()
            }
            .padding()
            .background(reBackground())
            .navigationTitle("New Box")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("cancel") {
                        print("Cancel")
                        dismiss()
                    }
                    .fontWeight(.bold)
                }

                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        print("Salve")
                        create()
                        dismiss()
                    }
                    .fontWeight(.bold)
                }
            }
        }
    }

    private func create() {
        let box = Box(
            identifier: .init(),
            name: name,
            keywords: keywords,
            descriptions: descriptions,
            rawTheme: rawTheme,
            terms: []
        )
        modelContext.insert(box)
    }
}

//#Preview {
//    BoxCreationView { _ in }
//}
