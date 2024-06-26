//
//  TodaysCardView.swift
//  reMind
//
//  Created by Luiz Araujo on 25/02/24.
//

import SwiftUI

struct TodaysCardView: View {
    var terms: [Term]
    @State var theme: reTheme

    private var review: SwipeReview {
        SwipeReview.getTermsToReview(terms: self.terms)
    }

    var numberOfPendingCards: Int {
        SwipeReview.getTermsToReview(terms: self.terms).termsToReview.count
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Today's Cards")
                .font(.title)
                .fontWeight(.semibold)
            Text("\(numberOfPendingCards) card\(numberOfPendingCards == 1 ? "": "s") to review")
                .font(.title3)

            NavigationLink {
                SwipperView(review: review)

            } label: {
                Text("Start Swipping")
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(reColorButtonStyle(theme))
            .padding(.top, 10)
            .disabled(numberOfPendingCards <= 0)
            .opacity(numberOfPendingCards <= 0 ? 0.5 : 1.0)
        }
        .padding(.vertical, 16)
    }
}


//#Preview {
////    TodaysCardView(
////        review: SwipeReview(termsToReview: BoxView_Previews.terms, termsReviewed: []),
////        numberOfPendingCards: 10,
////        theme: .mauve
////    )
//    TodaysCardView(
//        terms: .constant(BoxView_Previews.terms),
////        numberOfPendingCards: 10,
//        theme: .mauve
//    )
//        .padding()
//}
