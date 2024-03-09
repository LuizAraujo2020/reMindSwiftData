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
    @State private var searchText = ""

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
                        //                    ForEach(viewModel.boxes) { box in
//                        ForEach(boxes) { box in
                        ForEach(filteredBoxes) { box in
                            NavigationLink {
                                BoxView(box: box)

                            } label: {
                                BoxCardView(box: box)
                                    .reBadge(box.getNumberOfPendingTerms())
                            }
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

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(boxes[index])
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
