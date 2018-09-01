//
//  Presenter.swift
//  MuseumMedia
//
//  Created by Bruce McTigue on 7/3/18.
//  Copyright © 2018 tiguer. All rights reserved.
//

import Foundation

protocol PresentationLogic: class {
    func presentFetchedItems(response: MuseumMedia.FetchItems.Response)
}

class Presenter: PresentationLogic {
    weak var viewController: Displayable?
    
    init(controller: Displayable) {
        self.viewController = controller
    }
    
    func presentFetchedItems(response: MuseumMedia.FetchItems.Response) {
        var displayed: [MuseumMedia.FetchItems.ViewModel.DisplayedItem] = []
        for item in response.items {
            let displayedItem = MuseumMedia.FetchItems.ViewModel.DisplayedItem(title: item.title, imageUrl: item.imageUrl, description: item.itemDescription)
            displayed.append(displayedItem)
        }
        let viewModel = MuseumMedia.FetchItems.ViewModel(displayedItems: displayed)
        viewController?.displayFetchedItems(viewModel: viewModel)
    }
}
