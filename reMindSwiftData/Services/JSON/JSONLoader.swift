//
//  JSONLoader.swift
//  reMindSwiftData
//
//  Created by Luiz Araujo on 09/03/24.
//

import Foundation

struct JSONLoader {
//    func load<T: Codable>(url urlString: String) async {
//        guard let url = URL(string: urlString) else { return }
//
//        let urlSession = URLSession.shared
//
//        do {
//            let (data, response) = try await urlSession.data(from: url)
//            self.countries = try JSONDecoder().decode([T].self, from: data)
//        }
//        catch {
//            // Error handling in case the data couldn't be loaded
//            // For now, only display the error on the console
//            debugPrint("Error loading \(url): \(String(describing: error))")
//        }
//    }

    static func load(filename: String) -> JSONBox? {
        guard let file = Bundle.main.path(forResource: filename, ofType: "json") else {
            fatalError("Unable to locate file \"\(filename)\" in main bundle.")
        }

        do {
//            return try String(contentsOfFile: file).data(using: .utf8)
            let data = try String(contentsOfFile: file).data(using: .utf8) ?? Data()
            return try JSONDecoder().decode(JSONBox.self, from: data)
        } catch {
            fatalError("Unable to load \"\(filename)\" from main bundle:\n\(error)")
        }
    }

    static func load<T: Codable>(filename: String) -> T? {
        guard let file = Bundle.main.path(forResource: filename, ofType: "json") else {
            fatalError("Unable to locate file \"\(filename)\" in main bundle.")
        }

        do {
//            return try String(contentsOfFile: file).data(using: .utf8)
            let data = try String(contentsOfFile: file).data(using: .utf8) ?? Data()
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            fatalError("Unable to load \"\(filename)\" from main bundle:\n\(error)")
        }
    }
}
