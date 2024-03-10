//
//  BoxesView.swift
//  reMind
//
//  Created by Luiz Araujo on 15/02/24.
//

import SwiftUI
import SwiftData

struct BoxesView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \Box.name) private var boxes: [Box]

    @State var isCreatingNewBox = false
    @State var isShowingInspector = false
    @State private var searchText = ""
    @State private var boxToDelete: Box?

    private var filteredBoxes: [Box] {
        if searchText.isEmpty {
            return boxes
        }

        let items = boxes.compactMap { item in
            let nameContainsQuery = item.name.range(
                of: searchText,
                options: .caseInsensitive
            ) != nil

            return nameContainsQuery ? item : nil
        }

        return items
    }

    private let columns: [GridItem] = [
        GridItem(.adaptive(minimum: 140), spacing: 20),
        GridItem(.adaptive(minimum: 140), spacing: 20)
    ]

    var body: some View {
        NavigationStack {
            ScrollView(.vertical, showsIndicators: false) {
                if boxes.isEmpty {
                    ContentUnavailableView(
                        "Enter your first box",
                        systemImage: "shippingbox"
                    )
                } else {
                    LazyVGrid(columns: columns, spacing: 20) {
                        ForEach(Array(filteredBoxes.enumerated()), id: \.offset) { index, box in
                            NavigationLink {
                                BoxView(box: box)
                                
                            } label: {
                                BoxCardView(box: box)
                                    .reBadge(box.getNumberOfPendingTerms())
                                    .alert(isPresented: $isShowingInspector) {
                                        Alert(
                                            title: Text("Are you sure you want to delete this box?"),
                                            message: Text("There is no undo"),
                                            primaryButton: .destructive(Text("Delete")) {
                                                if let boxToDelete {
                                                    modelContext.delete(boxToDelete)
                                                }
                                            },
                                            secondaryButton: .cancel()
                                        )
                                    }

                            }
                            .simultaneousGesture(LongPressGesture().onEnded { _ in
                                boxToDelete = box
                                isShowingInspector.toggle()
                            })
                        }
                     }
                    .padding(40)
                }
            }
            .padding(-20)
            .navigationTitle("Boxes")
            .background(reBackground())
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        isCreatingNewBox.toggle()
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
        }
        .searchable(text: $searchText, prompt: "")
        .sheet(isPresented: $isCreatingNewBox) {
            BoxCreationView()
        }
    }

    private func addItem() {
        withAnimation {
            let newItem = Box(
                identifier: .init(),
                name: "Mock 1",
                keywords: "Mock, Teste",
                descriptions: "Test Mock ",
                rawTheme: 0,
                terms: []
            )
            modelContext.insert(newItem)
        }
    }

//    @MainActor
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {

                DispatchQueue.main.async {
                    modelContext.delete(filteredBoxes[index])
                }
            }
        }
    }
}

#Preview {
    //    let boxes: [Box] = {
    //        let box1 = Box(context: CoreDataStack.inMemory.managedContext)
    //        box1.name = "Box 1"
    //        box1.rawTheme = 0
    //
    //        let box2 = Box(context: CoreDataStack.inMemory.managedContext)
    //        box2.name = "Box 2"
    //        box2.rawTheme = 1
    //
    //        let box3 = Box(context: CoreDataStack.inMemory.managedContext)
    //        box3.name = "Box 3"
    //        box3.rawTheme = 2
    //
    //        return [box1, box2, box3]
    //    }()

//    BoxesView(viewModel: BoxesViewModel())
    BoxesView()
        .modelContainer(for: Box.self, inMemory: true)
}
