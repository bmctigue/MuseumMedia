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
    var jsonItems: [Item] = []
    
    override func setUp() {
        self.store = MemStore(urlString: nil)
    }
    
    func testFetchItems() {
        let expectation = self.expectation(description: "FetchItems")
        
        self.store.fetchItems(urlString: store.urlString, completionHandler: { (items,error) in
            if error == nil {
                self.jsonItems = items
                expectation.fulfill()
            }
        })
        
        waitForExpectations(timeout: 3.0, handler: nil)
        XCTAssertTrue(jsonItems.count == 2)
    }
    
}
