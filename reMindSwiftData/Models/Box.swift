//
//  Box.swift
//  reMindSwiftData
//
//  Created by Luiz Araujo on 08/03/24.
//

import Foundation
import SwiftData

@Model
final class Box: Identifiable {
    var identifier: UUID
    var name: String
    var keywords: String
    var descriptions: String
    var rawTheme: Int
    var terms: [Term]

    internal init(
        identifier: UUID,
        name: String,
        keywords: String,
        descriptions: String,
        rawTheme: Int,
        terms: [Term]
    ) {
        self.identifier = identifier
        self.name = name
        self.keywords = keywords
        self.descriptions = descriptions
        self.rawTheme = rawTheme
        self.terms = terms
    }
}

// MARK: - Helpers
extension Box {

    var numberOfTerms: Int { self.terms.count }

    var theme: reTheme {
        return reTheme(rawValue: self.rawTheme) ?? reTheme.lavender
    }

    func getNumberOfPendingTerms() -> Int {
        var result = 0
        guard !terms.isEmpty else { return result }

        for term in self.terms where term.isPending {
            result += 1
        }

        return result
    }
}

// MARK: - Statics
extension Box {
    static func createEmpty() -> Box {
        Box(
            identifier: .init(),
            name: "",
            keywords: "",
            descriptions: "",
            rawTheme: 0,
            terms: []
        )
    }
}
