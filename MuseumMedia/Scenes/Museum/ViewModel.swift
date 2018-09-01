//
//  ChangeMeModel.swift
//  MuseumMedia
//
//  Created by Bruce McTigue on 7/3/18.
//  Copyright © 2018 tiguer. All rights reserved.
//

import Foundation

enum MuseumMedia {
    enum FetchMediaIds {
        struct Request {}
        struct Response {
            var mediaIds: [MediaId]
        }
    }
    
    enum FetchItem {
        struct Request {
            var mediaId: MediaId
        }
        struct Response {
            var item: Item
        }
        struct ViewModel {
            struct DisplayedItem {
                var id: String
                var name: String
                var url: String
                var duration: Int
                var quality: String
            }
            var displayedItem: DisplayedItem
        }
    }
}
