//
//  Presenter.swift
//  MuseumMedia
//
//  Created by Bruce McTigue on 7/3/18.
//  Copyright © 2018 tiguer. All rights reserved.
//

import Foundation

protocol PresentationLogic: class {
    func presentFetchedItem(response: MuseumMedia.FetchItem.Response)
}

class Presenter: PresentationLogic {
    weak var viewController: Displayable?
    
    init(controller: Displayable) {
        self.viewController = controller
    }
    
    func presentFetchedItem(response: MuseumMedia.FetchItem.Response) {
        let item = response.item
        let displayedItem = MuseumMedia.FetchItem.ViewModel.DisplayedItem(name: item.name, url: item.url)
        let viewModel = MuseumMedia.FetchItem.ViewModel(displayedItem: displayedItem)
        viewController?.displayFetchedItem(viewModel: viewModel)
    }
}
