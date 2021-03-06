//
//  Worker.swift
//  MuseumMedia
//
//  Created by Bruce McTigue on 7/3/18.
//  Copyright © 2018 tiguer. All rights reserved.
//

import Foundation

protocol StoreProtocol: class {
    var urlString: String? { get set }
    func fetchMediaIds(urlString: String?, completionHandler: @escaping ([MediaId], StoreError?) -> Void)
    func fetchItem(urlString: String, completionHandler: @escaping (Item, StoreError?) -> Void)
}

class Worker {
    
    var store: StoreProtocol!
    
    init(store: StoreProtocol) {
        self.store = store
    }
    
    func fetchMediaIds(completionHandler: @escaping ([MediaId]) -> Void) {
        store.fetchMediaIds(urlString: store.urlString) { (mediaIds, error) in
            guard error == nil else {
                DispatchQueue.main.async {
                    print(error!.localizedDescription)
                }
                return
            }
            DispatchQueue.main.async {
                completionHandler(mediaIds)
            }
        }
    }
    
    func fetchItem(mediaId: MediaId, completionHandler: @escaping (Item) -> Void) {
        if let storeUrlString = store.urlString {
            let urlString = storeUrlString + "/\(mediaId)"
            store.fetchItem(urlString: urlString) { (item, error) in
                guard error == nil else {
                    DispatchQueue.main.async {
                        print(error!.localizedDescription)
                    }
                    return
                }
                DispatchQueue.main.async {
                    completionHandler(item)
                }
            }
        }
    }
}

enum StoreError: Equatable, Error {
    case CannotFetch(String)
}

func == (lhs: StoreError, rhs: StoreError) -> Bool {
    switch (lhs, rhs) {
    case (.CannotFetch(let a), .CannotFetch(let b)) where a == b:
        return true
    default:
        return false
    }
}
