//
//  Builder.swift
//  MuseumMedia
//
//  Created by Bruce McTigue on 8/18/18.
//  Copyright © 2018 tiguer. All rights reserved.
//

import Foundation

class Builder {
    
    weak var viewController: Playable?
    
    init(viewController: Playable) {
        self.viewController = viewController
        let store = JsonStore(urlString: Constants.jsonUrl)
        let presenter = Presenter(controller: viewController)
        let interactor = Interactor(presenter: presenter, store: store)
        viewController.interactor = interactor
        viewController.mediaManager = MediaManager(controller: viewController)
    }
}
