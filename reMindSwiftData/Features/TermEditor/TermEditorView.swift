//
//  TermEditorView.swift
//  reMind
//
//  Created by Luiz Araujo on 24/02/24.
//

import SwiftUI

struct TermEditorView: View {
    @Environment(\.dismiss) var dismiss

    @State var value: String
    @State var meaning: String

    @State private var errorMessage: String? = nil
    @State private var valueField = false
    @State private var meaningField = false

    var validation = TextValidation()

    let editTerm: (String, String) -> Void

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                reTextField(text: $value, title: "Term")
                    .modifier(ErrorHighlightModifier(show: $valueField))

                reTextField(text: $meaning, title: "Meaning")
                    .modifier(ErrorHighlightModifier(show: $meaningField))

                Spacer()

                if let errorMessage {
                    Text(errorMessage)
                        .font(.body)
                        .foregroundStyle(Palette.selectionColor.render)
                        .padding(.vertical, 5)
                        .padding(.horizontal, 20)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundStyle(Color.accentColor.opacity(0.5))
                        )
                }

                Spacer()

                Button {
                    guard validateFields() else { return }

                    saveChanges()
                    dismiss()
                } label: {
                    Text("Save Changes")
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(reButtonStyle())
            }
            .padding()
            .background(reBackground())
            .navigationTitle("New Term")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("cancel") {
                        dismiss()
                        print("Cancel")
                    }
                    .fontWeight(.bold)
                }

                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        guard validateFields() else { return }

                        saveChanges()
                        dismiss()
                    }
                    .fontWeight(.bold)
                }
            }
        }
    }

    private func validateFields() -> Bool {

        do {
            valueField = true
            try validation.isntEmpty(value)
            try validation.maxSize(value, 50)
            valueField = false
            meaningField = true
            try validation.maxSize(meaning, 150)
            meaningField = false

            errorMessage = nil

            return true
        } catch let error as TextValidationError {
            errorMessage = """
                            Error:
                            \(error.localizedDescription)
                            """
            return false

        } catch {
            print("asdasd")
            return false
        }
    }

    private func saveChanges() {
        editTerm(value, meaning)
    }
}
