//
//  BoxEditorView.swift
//  reMind
//
//  Created by Luiz Araujo on 24/02/24.
//

import SwiftUI
//
struct BoxEditorView: View {
    @Environment(\.dismiss) var dismiss

    let box: Box

    @State private var name: String = ""
    @State private var keywords: String = ""
    @State private var descriptions: String = ""
    @State private var rawTheme: Int = 0



    @State private var errorMessage: String?
    @State private var fieldName = false
    @State private var fieldKey = false
    @State private var fieldDescription = false

    //    var validation: (any Validateable)?
    var validation = TextValidation()

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                reTextField(
                    text: $name,
                    title: "Name"
                )
                .modifier(ErrorHighlightModifier(show: $fieldName))

                reTextField(
                    text: $keywords,
                    title: "Keywords",
                    caption: "Separated by , (comma)"
                )

                reTextEditor(text: $descriptions, title: "Description")
                    .modifier(ErrorHighlightModifier(show: $fieldDescription))

                reRadionButtonGroup(currentSelection: $rawTheme, title: "Theme")

                Spacer()

                if let errorMessage {
//                    ZStack {
                        Text(errorMessage)
                            .font(.body)
                            .foregroundStyle(Palette.selectionColor.render)
                            .padding(.vertical, 5)
                            .padding(.horizontal, 20)
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .foregroundStyle(Color.accentColor.opacity(0.5))
                            )
//                    }
                }
            }
            .padding()
            .background(reBackground())
            .navigationTitle("Editing Box")
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

                        do {
                            fieldName = true
                            try validation.isntEmpty(name)
                            try validation.maxSize(name, 50)
                            fieldName = false

                            fieldKey = true
                            try validation.maxSize(keywords, 150)
                            fieldKey = false
                            
                            fieldDescription = true
                            try validation.maxSize(descriptions, 150)
                            fieldKey = false

                            errorMessage = nil

                            updateBox()

                            dismiss()
                        } catch let error as TextValidationError {
                            errorMessage = """
                            Error:
                            \(error.localizedDescription)
                            """
                        } catch {
                            print("asdasd")
                        }
                    }
                    .fontWeight(.bold)
                }
            }
        }
        .onAppear {
            resetFields()
        }
    }

    private func resetFields() {
        name = box.name
        keywords = box.keywords
        descriptions = box.descriptions
        rawTheme = box.rawTheme
    }

    private func updateBox() {
        box.name = name
        box.keywords = keywords
        box.descriptions = descriptions
        box.rawTheme = rawTheme
    }
}

//#Preview {
////    let box: Box = {
////        let box = Box(context: CoreDataStack.inMemory.managedContext)
////        box.name = "Box 1"
////        box.rawTheme = 0
////        BoxView_Previews.terms.forEach { term in
////            box.addToTerms(term)
////        }
////        return box
////    }()
//
////    let terms: [Term] = {
////        let term1 = Term(context: CoreDataStack.inMemory.managedContext)
////        term1.value = "Term 1"
////
////        let term2 = Term(context: CoreDataStack.inMemory.managedContext)
////        term2.value = "Term 2"
////
////        let term3 = Term(context: CoreDataStack.inMemory.managedContext)
////        term3.value = "Term 3"
////
////        return [term1, term2, term3]
////    }()
//
//    return BoxEditorView(box: BoxView_Previews.box)
//}
//
//
struct ErrorHighlightModifier: ViewModifier {
    @Binding var show: Bool

    func body(content: Content) -> some View {
        if show {
            content
                .shadow(color: Palette.error.render, radius: 10)
//                .overlay {
//                    RoundedRectangle(cornerRadius: 10)
//                        .stroke(Palette.error.render, lineWidth: 5)
//                }
        } else {
            content
        }
    }
}
