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
    
    var item: Item!
    
    override func setUp() {
        super.setUp()
    }
    
    func testShowInit() {
        let testItem = Item(id: MemStore.id, name: MemStore.name, url: MemStore.url, duration: MemStore.duration, quality: MemStore.quality)
        XCTAssert(testItem.id == MemStore.item.id)
    }
}
