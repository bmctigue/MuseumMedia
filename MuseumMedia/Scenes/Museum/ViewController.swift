//
//  ViewController.swift
//  MuseumMedia
//
//  Created by Bruce McTigue on 9/1/18.
//  Copyright © 2018 tiguer. All rights reserved.
//

import UIKit

protocol Displayable: class {
    var builder: Builder? { get set }
    var interactor: BusinessLogic? { get set }
    func updateMediaIds(mediaIds: [MediaId])
    func fetch(mediaId: MediaId)
    func displayFetchedItem(viewModel: MuseumMedia.FetchItem.ViewModel)
}

class ViewController: UIViewController, Displayable {
    
    var builder: Builder?
    var interactor: BusinessLogic?
    var displayedItem: MuseumMedia.FetchItem.ViewModel.DisplayedItem?
    var mediaIds: [MediaId] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.builder = Builder(viewController: self)
        fetchMediaIds()
    }
    
    func fetchMediaIds() {
        let request = MuseumMedia.FetchMediaIds.Request()
        interactor?.fetchMediaIds(request: request)
    }
    
    func updateMediaIds(mediaIds: [MediaId]) {
        self.mediaIds = mediaIds
    }
    
    func fetch(mediaId: MediaId) {
        let request = MuseumMedia.FetchItem.Request(mediaId: mediaId)
        interactor?.fetchItem(request: request)
    }
    
    func displayFetchedItem(viewModel: MuseumMedia.FetchItem.ViewModel) {
        displayedItem = viewModel.displayedItem
    }
}
