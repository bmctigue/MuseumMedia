//
//  Item.swift
//  MuseumMedia
//
//  Created by Bruce McTigue on 7/3/18.
//  Copyright © 2018 tiguer. All rights reserved.
//

import Foundation

typealias MediaId = String

struct Item: Codable, Equatable, Hashable {
    var id: MediaId
    var name: String
    var url: String
    var duration: Int
    var quality: String
    
    static func == (lhs: Item, rhs: Item) -> Bool {
        return lhs.id == rhs.id
    }
}

public struct LoopIterator<Base: Collection>: IteratorProtocol {
    
    private let collection: Base
    private var index: Base.Index
    
    public init(collection: Base) {
        self.collection = collection
        self.index = collection.startIndex
    }
    
    public mutating func next() -> Base.Iterator.Element? {
        guard !collection.isEmpty else {
            return nil
        }
        
        let result = collection[index]
        collection.formIndex(after: &index) // (*) See discussion below
        if index == collection.endIndex {
            index = collection.startIndex
        }
        return result
    }
}
