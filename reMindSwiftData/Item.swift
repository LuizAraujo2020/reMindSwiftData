//
//  Item.swift
//  reMindSwiftData
//
//  Created by Luiz Araujo on 08/03/24.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
