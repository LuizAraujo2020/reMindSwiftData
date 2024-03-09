//
//  TextValidation.swift
//  reMind
//
//  Created by Luiz Araujo on 27/02/24.
//

import Foundation

protocol Validator {
    associatedtype T
    var validations: [((_ value: T) -> Bool)] { get }

    func validate(_ value: T) -> Bool
}

extension Validator {
    func validate(_ value: T) -> Bool {

        for validation in self.validations {
            if  !validation(value) {
                return false
            }
        }

        return true
    }
}

enum TextValidationError: LocalizedError {
    case isEmpty
    case exceededSize(Int)
    case invalidChar

    var errorDescription: String? {
        switch self {
        case .isEmpty: return "The field highlighted cannot be empty."
        case .exceededSize(let size): return "The field highlighted cannot have more than \(size) characters."
        case .invalidChar: return "The field highlighted cannot have special characters."
        }
    }
}

struct TextValidation {

    @discardableResult
    func isntEmpty(_ suv: String) throws -> String {
        guard !suv.isEmpty else {
            throw TextValidationError.isEmpty
        }

        return suv
    }

    @discardableResult
    func maxSize(_ suv: String, _ size: Int) throws -> String {
        guard suv.count <= size else {
            throw TextValidationError.exceededSize(size)
        }

        return suv
    }

    @discardableResult
    func maxSize50(_ suv: String) throws -> String {
        let size = 50
        guard suv.count <= size else {
            throw TextValidationError.exceededSize(size)
        }

        return suv
    }

    @discardableResult
    func maxSize150(_ suv: String) throws -> String {
        let size = 150
        guard suv.count <= size else {
            throw TextValidationError.exceededSize(size)
        }

        return suv
    }

    func dontHave(_ suv: String, _ chars:  [String]) throws -> String {
        for char in chars {
            if suv.contains(char) {
                throw TextValidationError.invalidChar
            }
        }

        return suv
    }
}

