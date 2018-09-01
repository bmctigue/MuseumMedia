//
//  ItemTests.swift
//  MuseumMediaTests
//
//  Created by Bruce McTigue on 8/18/18.
//  Copyright © 2018 tiguer. All rights reserved.
//

import XCTest
@testable import MuseumMedia

class ItemTests: XCTestCase {
    
    static let title = "Item one"
    static let imageUrl = "https://www.google.com"
    static let itemDescription = "Item one description"
    
    var item: Item!
    
    override func setUp() {
        super.setUp()
        self.item = Item(title: ItemTests.title, imageUrl: ItemTests.imageUrl, itemDescription: ItemTests.itemDescription)
    }
    
    func testShowInit() {
        let testItem = Item(title: ItemTests.title, imageUrl: ItemTests.imageUrl, itemDescription: ItemTests.itemDescription)
        XCTAssert(testItem.title == item.title)
    }
}
