//
//  MediaManager.swift
//  MuseumMedia
//
//  Created by Bruce McTigue on 9/1/18.
//  Copyright © 2018 tiguer. All rights reserved.
//

import Foundation

class MediaManager {
    
    weak var viewController: Playable?
    var mediaIds: LoopIterator<[MediaId]>?
    var itemsHash: Dictionary<String,MuseumMedia.FetchItem.ViewModel.DisplayedItem> = [:]
    var itemQueue: [MuseumMedia.FetchItem.ViewModel.DisplayedItem] = []
    
    init(controller: Playable) {
        self.viewController = controller
    }
    
    func nextItem() {
        if let nextMediaId = mediaIds?.next() {
            if let item = itemsHash[nextMediaId] {
                itemQueue.insert(item, at: 0)
            }
            viewController?.fetch(mediaId: nextMediaId)
        }
    }
}
