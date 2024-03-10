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

    @State private var name = ""
    @State private var keywords = ""
    @State private var descriptions = ""
    @State private var rawTheme = 0

    private let columns: [GridItem] = [
        GridItem(.adaptive(minimum: 140), spacing: 20),
        GridItem(.adaptive(minimum: 140), spacing: 20)
    ]

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

                ScrollView {
                    LazyVGrid(columns: columns, spacing: 20) {
                        
                        ForEach(Array(JSONLoader.load(filename: "hiragana1-terms").enumerated()), id: \.offset) { index, box in
                            Button {
                                createHiraganaBox(box)
                                dismiss()
                            } label: {
                                Text(box.name)
                                    .bold()
                                    .foregroundStyle(Palette.selectionColor.render)
                                    .frame(width: 75)
                            }
                            .buttonStyle(.borderedProminent)
                        }
                    }
                }
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

    private func createHiraganaBox(_ auxBox: JSONBox) {


        //            .onAppear {
//        guard let auxBox: JSONBox = JSONLoader.load(filename: "hiragana1-terms") else { return }

        let box = auxBox.createBoxWithTerms()
        modelContext.insert(box)
    }
}

//#Preview {
//    BoxCreationView { _ in }
//}
