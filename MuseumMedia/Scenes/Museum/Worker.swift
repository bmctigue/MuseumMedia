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
    func fetchItems(urlString: String?, completionHandler: @escaping ([Item], StoreError?) -> Void)
}

class Worker {
    
    var store: StoreProtocol!
    
    init(store: StoreProtocol) {
        self.store = store
    }
    
    func fetchItems(completionHandler: @escaping ([Item]) -> Void) {
        store.fetchItems(urlString: store.urlString) { (items, error) in
            guard error == nil else {
                DispatchQueue.main.async {
                    print(error!.localizedDescription)
                    completionHandler([])
                }
                return
            }
            DispatchQueue.main.async {
                completionHandler(items)
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
