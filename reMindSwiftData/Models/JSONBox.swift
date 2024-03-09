//
//  JSONBox.swift
//  reMindSwiftData
//
//  Created by Luiz Araujo on 09/03/24.
//

import Foundation

struct JSONBox: Codable {
    let name: String
    let type: String
    let keywords: String
    let descriptions: String
    let terms: [JSONTerm]

}

struct JSONTerm: Codable {
    let term: String
    let meaning: String
    let theme: Int
}

extension JSONBox {
    func createBox() -> Box {

        var terms = [Term]()

        for auxTerm in self.terms {
            let term = Term(
                creationDate: .now,
                identifier: UUID(),
                lastReview: .now,
                meaning: auxTerm.meaning,
                rawSRS: 0,
                rawTheme: auxTerm.theme,
                value: auxTerm.term
            )

            terms.append(term)
        }

        var box = Box(
            identifier: UUID(),
            name: self.name,
            keywords: self.keywords,
            descriptions: self.descriptions,
            rawTheme: 0,
            terms: terms
        )


        return box
    }
}
