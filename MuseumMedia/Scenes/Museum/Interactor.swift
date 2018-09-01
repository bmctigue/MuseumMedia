//
//  Interactor.swift
//  MuseumMedia
//
//  Created by Bruce McTigue on 7/3/18.
//  Copyright © 2018 tiguer. All rights reserved.
//

import Foundation

protocol BusinessLogic: class {
    func fetchMediaIds(request: MuseumMedia.FetchMediaIds.Request)
    func fetchItem(request: MuseumMedia.FetchItem.Request)
}

class Interactor: BusinessLogic {
    
    var presenter: PresentationLogic!
    var worker: Worker!
    
    init(presenter: PresentationLogic, store: StoreProtocol) {
        self.presenter = presenter
        self.worker = Worker(store: store)
    }
    
    func fetchMediaIds(request: MuseumMedia.FetchMediaIds.Request) {
        worker.fetchMediaIds { mediaIds in
            let response = MuseumMedia.FetchMediaIds.Response(mediaIds: mediaIds)
            self.presenter.updateFetchedMediaIds(response: response)
        }
    }
    
    func fetchItem(request: MuseumMedia.FetchItem.Request) {
        worker.fetchItem(mediaId: request.mediaId) { item in
            let response = MuseumMedia.FetchItem.Response(item: item)
            self.presenter.presentFetchedItem(response: response)
        }
    }
}
