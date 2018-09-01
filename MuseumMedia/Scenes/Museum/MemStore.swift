//
//  MemStore.swift
//  MuseumMedia
//
//  Created by Bruce McTigue on 7/3/18.
//  Copyright © 2018 tiguer. All rights reserved.
//

import Foundation

class MemStore: StoreProtocol {    
    
    static let id = "b4c4a8da-ba8d-4b3d-8ec2-70e3b69667af"
    static let name = "media-item-1"
    static let url = "https://s3-us-west-2.amazonaws.com/mediacore-bucket/Beija_Flor_na_Chuva.mp4"
    static let duration = 5
    static let quality = "auto"
    static let item = Item(id: id, name: name, url: url, duration: duration, quality: quality)
    
    var urlString: String?
    
    init(urlString: String?) {
        self.urlString = urlString
    }
    
    func fetchItem(urlString: String?, completionHandler: @escaping (Item, StoreError?) -> Void) {
        completionHandler(type(of: self).item, nil)
    }
}
