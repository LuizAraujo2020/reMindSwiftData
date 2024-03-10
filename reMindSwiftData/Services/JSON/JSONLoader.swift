//
//  JSONLoader.swift
//  reMindSwiftData
//
//  Created by Luiz Araujo on 09/03/24.
//

import Foundation

struct JSONLoader {

    static func load(filename: String) -> [JSONBox] {
        guard let file = Bundle.main.path(forResource: filename, ofType: "json") else {
            fatalError("Unable to locate file \"\(filename)\" in main bundle.")
        }

        do {
            let data = try String(contentsOfFile: file).data(using: .utf8) ?? Data()
            return try JSONDecoder().decode([JSONBox].self, from: data)

        } catch {
            fatalError("Unable to load \"\(filename)\" from main bundle:\n\(error)")
        }
    }
}
