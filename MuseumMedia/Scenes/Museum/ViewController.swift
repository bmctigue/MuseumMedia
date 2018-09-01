//
//  ViewController.swift
//  MuseumMedia
//
//  Created by Bruce McTigue on 9/1/18.
//  Copyright © 2018 tiguer. All rights reserved.
//

import UIKit

protocol Playable: class {
    var builder: Builder? { get set }
    var interactor: BusinessLogic? { get set }
    var mediaManager: MediaManager? { get set }
    func updateMediaIds(mediaIds: [MediaId])
    func fetch(mediaId: MediaId)
    func displayFetchedItem(viewModel: MuseumMedia.FetchItem.ViewModel)
}

class ViewController: UIViewController, Playable {
    
    var builder: Builder?
    var interactor: BusinessLogic?
    var mediaManager: MediaManager?
    var displayedItem: MuseumMedia.FetchItem.ViewModel.DisplayedItem?
    
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
        mediaManager?.mediaIds = LoopIterator<[MediaId]>(collection: mediaIds)
        mediaManager?.nextItem()
    }
    
    func fetch(mediaId: MediaId) {
        let request = MuseumMedia.FetchItem.Request(mediaId: mediaId)
        interactor?.fetchItem(request: request)
    }
    
    func displayFetchedItem(viewModel: MuseumMedia.FetchItem.ViewModel) {
        let displayedItem = viewModel.displayedItem
        mediaManager?.itemQueue.insert(displayedItem, at: 0)
        mediaManager?.itemsHash[displayedItem.id] = displayedItem
        play()
    }
    
    func play() {
        if let nextItem = mediaManager?.itemQueue.popLast() {
            let itemUrl = nextItem.url
            print(itemUrl)
        }
    }
}
