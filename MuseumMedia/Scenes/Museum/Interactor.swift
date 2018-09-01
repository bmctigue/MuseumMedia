//
//  Interactor.swift
//  MuseumMedia
//
//  Created by Bruce McTigue on 7/3/18.
//  Copyright © 2018 tiguer. All rights reserved.
//

import Foundation

protocol BusinessLogic: class {
    func fetchItems(request: MuseumMedia.FetchItems.Request)
}

class Interactor: BusinessLogic {
    
    var presenter: PresentationLogic!
    var worker: Worker!
    
    init(presenter: PresentationLogic, store: StoreProtocol) {
        self.presenter = presenter
        self.worker = Worker(store: store)
    }
    
    func fetchItems(request: MuseumMedia.FetchItems.Request) {
        worker.fetchItems { (items) in
            let response = MuseumMedia.FetchItems.Response(items: items)
            self.presenter.presentFetchedItems(response: response)
        }
    }
}
