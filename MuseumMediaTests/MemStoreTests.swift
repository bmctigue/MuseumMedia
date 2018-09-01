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
    var jsonItem: Item!
    
    override func setUp() {
        self.store = MemStore(urlString: nil)
    }
    
    func testFetchItem() {
        let expectation = self.expectation(description: "FetchItem")
        
        self.store.fetchItem(urlString: store.urlString, completionHandler: { (item,error) in
            if error == nil {
                self.jsonItem = item
                expectation.fulfill()
            }
        })
        
        waitForExpectations(timeout: 3.0, handler: nil)
        XCTAssertTrue(jsonItem.id == MemStore.item.id)
    }
}
