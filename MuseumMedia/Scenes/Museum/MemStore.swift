//
//  MemStore.swift
//  MuseumMedia
//
//  Created by Bruce McTigue on 7/3/18.
//  Copyright © 2018 tiguer. All rights reserved.
//

import Foundation

class MemStore: StoreProtocol {    
    
    static let id = "17c1c364-06a3-4df2-b775-5e12280abff5"
    static let name = "media-item-1"
    static let url = "https://s3-us-west-2.amazonaws.com/mediacore-bucket/Beija_Flor_na_Chuva.mp4"
    static let duration = 5
    static let quality = "auto"
    static let item = Item(id: id, name: name, url: url, duration: duration, quality: quality)
    static let mediaIds = ["17c1c364-06a3-4df2-b775-5e12280abff5", "6b21f104-59ea-4cb0-a9f8-991c8d183e82"]
    
    var urlString: String?
    
    init(urlString: String?) {
        self.urlString = urlString
    }
    
    func fetchMediaIds(urlString: String?, completionHandler: @escaping ([MediaId], StoreError?) -> Void) {
        completionHandler(type(of: self).mediaIds, nil)
    }
    
    func fetchItem(urlString: String, completionHandler: @escaping (Item, StoreError?) -> Void) {
        completionHandler(type(of: self).item, nil)
    }
}
