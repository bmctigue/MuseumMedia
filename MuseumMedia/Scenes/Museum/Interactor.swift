//
//  Interactor.swift
//  MuseumMedia
//
//  Created by Bruce McTigue on 7/3/18.
//  Copyright © 2018 tiguer. All rights reserved.
//

import Foundation

protocol BusinessLogic: class {
    func fetchItem(request: MuseumMedia.FetchItem.Request)
}

class Interactor: BusinessLogic {
    
    var presenter: PresentationLogic!
    var worker: Worker!
    
    init(presenter: PresentationLogic, store: StoreProtocol) {
        self.presenter = presenter
        self.worker = Worker(store: store)
    }
    
    func fetchItem(request: MuseumMedia.FetchItem.Request) {
        worker.fetchItem { item in
            let response = MuseumMedia.FetchItem.Response(item: item)
            self.presenter.presentFetchedItem(response: response)
        }
    }
}
