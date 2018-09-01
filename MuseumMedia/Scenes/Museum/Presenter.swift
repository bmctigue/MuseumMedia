//
//  Presenter.swift
//  MuseumMedia
//
//  Created by Bruce McTigue on 7/3/18.
//  Copyright © 2018 tiguer. All rights reserved.
//

import Foundation

protocol PresentationLogic: class {
    func updateFetchedMediaIds(response: MuseumMedia.FetchMediaIds.Response)
    func presentFetchedItem(response: MuseumMedia.FetchItem.Response)
}

class Presenter: PresentationLogic {
    weak var viewController: Playable?
    
    init(controller: Playable) {
        self.viewController = controller
    }
    
    func updateFetchedMediaIds(response: MuseumMedia.FetchMediaIds.Response) {
        viewController?.updateMediaIds(mediaIds: response.mediaIds)
    }
    
    func presentFetchedItem(response: MuseumMedia.FetchItem.Response) {
        let item = response.item
        let displayedItem = MuseumMedia.FetchItem.ViewModel.DisplayedItem(id: item.id, name: item.name, url: item.url, duration: item.duration, quality: item.quality)
        let viewModel = MuseumMedia.FetchItem.ViewModel(displayedItem: displayedItem)
        viewController?.displayFetchedItem(viewModel: viewModel)
    }
}
