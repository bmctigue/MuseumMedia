//
//  Item.swift
//  MuseumMedia
//
//  Created by Bruce McTigue on 7/3/18.
//  Copyright © 2018 tiguer. All rights reserved.
//

import Foundation

typealias MediaId = String

struct Item: Codable, Equatable {
    var id: MediaId
    var name: String
    var url: String
    var duration: Int
    var quality: String
    
    static func == (lhs: Item, rhs: Item) -> Bool {
        return lhs.id == rhs.id
    }
}
