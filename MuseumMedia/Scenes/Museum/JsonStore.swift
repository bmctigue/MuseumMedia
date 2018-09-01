//
//  JsonStore.swift
//  MuseumMedia
//
//  Created by Bruce McTigue on 8/18/18.
//  Copyright © 2018 tiguer. All rights reserved.
//

import Foundation
import SwiftyJSON

class JsonStore: StoreProtocol {
    
    var urlString: String?
    
    init(urlString: String?) {
        self.urlString = urlString
    }
    
    func fetchMediaIds(urlString: String?, completionHandler: @escaping ([MediaId], StoreError?) -> Void) {
        if let urlString = urlString {
            guard let url = URL(string: urlString) else { return }
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print(error!.localizedDescription)
                }
                
                guard let data = data else { return }
                do {
                    let json = try JSON(data: data)
                    let mediaIds = json["media_items"].arrayValue.map{MediaId($0.stringValue)}
                    completionHandler(mediaIds, nil)
                } catch let jsonError {
                    print(jsonError)
                }
                
                }.resume()
        }
    }
    
    func fetchItem(urlString: String, completionHandler: @escaping (Item, StoreError?) -> Void) {
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
                print(error!.localizedDescription)
            }
            
            guard let data = data else { return }
            do {
                let json = try JSON(data: data)
                let id = json["id"]
                if let itemData = id.first {
                    let itemHash = itemData.1
                    let id = itemHash["id"].string ?? ""
                    let name = itemHash["name"].string ?? ""
                    let url = itemHash["url"].string ?? ""
                    let duration = itemHash["duration"].intValue
                    let quality = itemHash["quality"].string ?? ""
                    let item = Item(id: id, name: name, url: url, duration: duration, quality: quality)
                    completionHandler(item, nil)
                }
                
            } catch let jsonError {
                print(jsonError)
            }
            
        }.resume()
    }
}
