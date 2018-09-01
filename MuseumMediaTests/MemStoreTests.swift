//
//  MemStoreTests.swift
//  MuseumMediaTests
//
//  Created by Bruce McTigue on 8/20/18.
//  Copyright © 2018 tiguer. All rights reserved.
//

import XCTest
@testable import MuseumMedia

class MemStoreTests: XCTestCase {
    
    var store: MemStore!
    var mediaIds: [MediaId] = []
    var jsonItem: Item!
    
    override func setUp() {
        self.store = MemStore(urlString: nil)
        self.mediaIds = []
    }
    
    func testFetchMediaIds() {
        let expectation = self.expectation(description: "FetchItem")
        
        self.store.fetchMediaIds(urlString: store.urlString, completionHandler: { (mediaIds,error) in
            if error == nil {
                self.mediaIds = mediaIds
                expectation.fulfill()
            }
        })
        
        waitForExpectations(timeout: 3.0, handler: nil)
        XCTAssertTrue(self.mediaIds.count == MemStore.mediaIds.count)
    }
    
    func testFetchItem() {
        let expectation = self.expectation(description: "FetchItem")
        
        self.store.fetchItem(urlString: MemStore.item.id, completionHandler: { (item,error) in
            if error == nil {
                self.jsonItem = item
                expectation.fulfill()
            }
        })
        
        waitForExpectations(timeout: 3.0, handler: nil)
        XCTAssertTrue(jsonItem.id == MemStore.item.id)
    }
}
