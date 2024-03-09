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

    internal init() {
        self.creationDate = .now
        self.identifier = UUID()
        self.lastReview = .now
        self.meaning = ""
        self.rawSRS = 0
        self.rawTheme = 0
        self.value = "" 
        //        self._$backingData = _$backingData
    }

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

    var srs: SpacedRepetitionSystem {
        return SpacedRepetitionSystem(rawValue: rawSRS) ?? SpacedRepetitionSystem.first
    }

    var theme: reTheme {
        return reTheme(rawValue: self.rawTheme) ?? reTheme.lavender
    }
}

enum SpacedRepetitionSystem: Int {
    case none = 0
    case first = 1
    case second = 2
    case third = 3
    case fourth = 5
    case fifth = 8
    case sixth = 13
    case seventh = 21

    var next: Self {
        switch self {
        case .none: return .first
        case .first: return .second
        case .second: return.third
        case .third: return .fourth
        case .fourth: return.fifth
        case .fifth: return .sixth
        case .sixth, .seventh: return .seventh

        }
    }

    var previous: Self {
        switch self {
        case .none, .first: return .none
        case .second: return.first
        case .third: return .second
        case .fourth: return.third
        case .fifth: return .fourth
        case .sixth: return .fifth
        case .seventh: return .sixth

        }
    }
}
