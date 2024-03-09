//
//  Term.swift
//  reMindSwiftData
//
//  Created by Luiz Araujo on 08/03/24.
//

import Foundation
import SwiftData

@Model
final class Term {
    var creationDate: Date
    var identifier: UUID
    var lastReview: Date
    var meaning: String
    var rawSRS: Int
    var rawTheme: Int
    var value: String
//    var boxID: Box?

    internal init(
        creationDate: Date,
        identifier: UUID,
        lastReview: Date,
        meaning: String,
        rawSRS: Int,
        rawTheme: Int,
        value: String//,
//        _$backingData: any BackingData<Term> = Term.createBackingData()
    ) {
        self.creationDate = creationDate
        self.identifier = identifier
        self.lastReview = lastReview
        self.meaning = meaning
        self.rawSRS = rawSRS
        self.rawTheme = rawTheme
        self.value = value
//        self._$backingData = _$backingData
    }
}


extension Term {

    /// Check if it is pending.
    var isPending: Bool {

        let srs = Int(self.rawSRS)

        guard srs > 0 else { return true }

        guard let nextReview = Calendar.current.date(byAdding: .day, value: srs, to: self.lastReview)
        else { return false }

        return nextReview <= Date()
    }
}
