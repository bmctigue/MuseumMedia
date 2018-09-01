//
//  JsonStore.swift
//  MuseumMedia
//
//  Created by Bruce McTigue on 8/18/18.
//  Copyright © 2018 tiguer. All rights reserved.
//

import Foundation

class JsonStore: StoreProtocol {
    var urlString: String?
    
    init(urlString: String?) {
        self.urlString = urlString
    }
    
    func fetchItems(urlString: String?, completionHandler: @escaping ([Item], StoreError?) -> Void) {
        if let urlString = urlString {
            guard let url = URL(string: urlString) else { return }
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print(error!.localizedDescription)
                }
                
                guard let data = data else { return }
                do {
                    let items = try JSONDecoder().decode([Item].self, from: data)
                    completionHandler(items, nil)
                    
                } catch let jsonError {
                    print(jsonError)
                }
                
            }.resume()
        }
    }
}
