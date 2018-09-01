//
//  ChangeMeModel.swift
//  MuseumMedia
//
//  Created by Bruce McTigue on 7/3/18.
//  Copyright © 2018 tiguer. All rights reserved.
//

import Foundation

enum MuseumMedia {
    enum FetchItems {
        struct Request {}
        struct Response {
            var items: [Item]
        }
        struct ViewModel {
            struct DisplayedItem {
                var title: String
                var imageUrl: String
                var description: String
            }
            var displayedItems: [DisplayedItem]
        }
    }
}
