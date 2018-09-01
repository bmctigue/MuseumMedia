//
//  ChangeMeModel.swift
//  MuseumMedia
//
//  Created by Bruce McTigue on 7/3/18.
//  Copyright © 2018 tiguer. All rights reserved.
//

import Foundation

enum MuseumMedia {
    enum FetchItem {
        struct Request {}
        struct Response {
            var item: Item
        }
        struct ViewModel {
            struct DisplayedItem {
                var name: String
                var url: String
            }
            var displayedItem: DisplayedItem
        }
    }
}
