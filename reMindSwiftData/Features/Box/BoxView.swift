//
//  BoxView.swift
//  reMind
//
//  Created by Luiz Araujo on 24/02/24.
//

import SwiftUI

struct BoxView: View {
    @Environment(\.modelContext) private var modelContext
    let box: Box

    @State private var isEditingBox = false
    @State private var isEditingTerm = false
    @State private var isCreatingTerm = false

    @State private var searchText: String = ""
    @State private var termIndex = 0

    private var filteredTerms: [Term] {
        if searchText.isEmpty {
            return box.terms.sorted { lhs, rhs in
                (lhs.value) < (rhs.value)
            }
        }

        let items = box.terms
            .filter { ($0.value).localizedStandardContains(searchText) ||
                ($0.meaning).localizedStandardContains(searchText)
            }
            .sorted { lhs, rhs in (lhs.value) < (rhs.value) }

        return items
    }

    var body: some View {
        VStack {
            TodaysCardView(
                terms: box.terms,
                theme: reTheme(rawValue: box.rawTheme) ?? .aquamarine
            )
            .padding(.horizontal)

            VStack {
                List {
                    Section {
                        ForEach(Array(filteredTerms.enumerated()), id: \.offset) { index, term in
                            NavigationLink {
                                SwipperView(
                                    review: SwipeReview(
                                        termsToReview: [term],
                                        termsReviewed: []
                                    )
                                )

                            } label: {
                                Text("\(term.value)")
                                    .padding(.vertical, 8)
                                    .fontWeight(term.isPending ? .bold : .regular)
                                    .swipeActions(edge: .trailing) {
                                        Button(role: .destructive) {
                                            print("delete")
                                            destroy(term)
                                        } label: {
                                            Image(systemName: "trash")
                                        }
                                    }
                                    .swipeActions(edge: .leading) {
                                        Button {
                                            print("edit term")
                                            termIndex = index
                                            isEditingTerm = true

                                        } label: {
                                            Image(systemName: "square.and.pencil")
                                        }
                                    }
                            }
                        }

                    } header: {
                        Text("All Cards")
                            .textCase(.none)
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundColor(Palette.label.render)
                            .padding(.leading, -16)
                            .padding(.bottom, 16)
                    }
                }
                .scrollContentBackground(.hidden)
                .background(reBackground())

                Spacer()

                /// Show Swipper Report button
                NavigationLink {
                    SwipperReportView(terms: box.terms)

                } label: {
                    Text("Show Report")
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(reButtonStyle())
                .padding()
                .opacity(box.terms.isEmpty ? 0.5 : 1.0)
                .disabled(box.terms.isEmpty)
            }
            .background(reBackground())
        }
        .navigationTitle(box.name)
        .searchable(text: $searchText, prompt: "")
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                Button {
                    print("edit")
                    isEditingBox = true
                } label: {
                    Image(systemName: "square.and.pencil")
                }

                Button {
                    print("add")
                    isCreatingTerm = true
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
        .sheet(isPresented: $isEditingBox) {
            BoxEditorView(box: box)
        }
        .sheet(isPresented: $isCreatingTerm) {
            TermCreatorView(box: box)
        }
        .sheet(isPresented: $isEditingTerm) {
            TermEditorView(
                value: box.terms[termIndex].value,
                meaning: box.terms[termIndex].meaning
            ) { value, meaning in
                box.terms[termIndex].value = value
                box.terms[termIndex].meaning = meaning
            }
        }
    }

    private func destroy(_ term: Term) {
        box.terms.removeAll { $0 == term }
        modelContext.delete(term)
        try? modelContext.save()
    }
}

//struct BoxView_Previews: PreviewProvider {
//    static let box: Box = {
//        let box = Box(context: CoreDataStack.inMemory.managedContext)
//        box.name = "Box 1"
//        box.rawTheme = 0
//        BoxView_Previews.terms.forEach { term in
//            box.addToTerms(term)
//        }
//        return box
//    }()
//
//    static let terms: [Term] = {
//        let term1 = Term(context: CoreDataStack.inMemory.managedContext)
//        term1.value = "Term 1"
//
//        let term2 = Term(context: CoreDataStack.inMemory.managedContext)
//        term2.value = "Term 2"
//
//        let term3 = Term(context: CoreDataStack.inMemory.managedContext)
//        term3.value = "Term 3"
//
//        return [term1, term2, term3]
//    }()
//
//    static var previews: some View {
//        NavigationStack {
//            BoxView(
//                box: BoxView_Previews.box,
//                terms: .constant([]),
//                termsToReview: [],
//                createTerm: { _ in })
//        }
//    }
//}



//import SwiftUI
//import SwiftData
//
//struct BookListView: View {
//    @Environment(\.modelContext) private var context
//    @Query(sort: \Book.title) private var books: [Book]
//    @State private var createNewBook = false
//    var body: some View {
//        NavigationStack {
//            Group {
//                if books.isEmpty {
//                    ContentUnavailableView("Enter your first book.", systemImage: "book.fill")
//                } else {
//                    List {
//                        ForEach(books) { book in
//                            NavigationLink {
////                                EditBookView(book: book)
//                            } label: {
//                                HStack(spacing: 10) {
//                                    book.icon
//                                    VStack(alignment: .leading) {
//                                        Text(book.title).font(.title2)
//                                        Text(book.author).foregroundStyle(.secondary)
//                                        if let rating = book.rating {
//                                            HStack {
//                                                ForEach(1..<rating, id: \.self) { _ in
//                                                    Image(systemName: "star.fill")
//                                                        .imageScale(.small)
//                                                        .foregroundStyle(.yellow)
//                                                }
//                                            }
//                                        }
//                                    }
//                                }
//                            }
//
//                        }
//                        .onDelete { indexSet in
//                            indexSet.forEach { index in
//                                let book = books[index]
//                                context.delete(book)
//                            }
//                        }
//                    }
//                    .listStyle(.plain)
//                }
//            }
//            .navigationTitle("My Books")
//            .toolbar {
//                Button {
//                    createNewBook = true
//                }label: {
//                    Image(systemName: "plus.circle.fill")
//                        .imageScale(.large)
//                }
//            }
//            .sheet(isPresented: $createNewBook) {
//                NewBookView()
//                    .presentationDetents([.medium])
//            }
//        }
//    }
//}
//
//#Preview {
//    BookListView()
//        .modelContainer(for: Book.self, inMemory: true)
//}
