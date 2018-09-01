//
//  MemStore.swift
//  MuseumMedia
//
//  Created by Bruce McTigue on 7/3/18.
//  Copyright © 2018 tiguer. All rights reserved.
//

import Foundation

class MemStore: StoreProtocol {

    static let title01 = "Space Keybaord Question"
    static let title02 = "Jiji"
    
    static let imageUrl01 = "https://triplebyte-cats.s3.amazonaws.com/space.jpg"
    static let imageUrl02 = "https://triplebyte-cats.s3.amazonaws.com/jiji.png"
    
    static let description01 = "In space, no one can hear you purr."
    static let description02 = "You'd think they'd never seen a girl and a cat on a broom before"

    static let items: [Item] = [
        Item(title: title01, imageUrl: imageUrl01, itemDescription: description01),
        Item(title: title02, imageUrl: imageUrl02, itemDescription: description02)
    ]
    
    var urlString: String?
    
    init(urlString: String?) {
        self.urlString = urlString
    }
    
    func fetchItems(urlString: String?, completionHandler: @escaping ([Item], StoreError?) -> Void) {
        completionHandler(type(of: self).items, nil)
    }
}
