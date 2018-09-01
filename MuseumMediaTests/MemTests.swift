//
//  JsonStoreTests.swift
//  MuseumMediaTests
//
//  Created by Bruce McTigue on 8/20/18.
//  Copyright © 2018 tiguer. All rights reserved.
//

import XCTest
@testable import MuseumMedia

class JsonStoreTests: XCTestCase {
    
    var urlString = Constants.jsonUrl
    var store: JsonStore!
    var jsonItems: [Item] = []
    
    override func setUp() {
        self.store = JsonStore(urlString:urlString)
    }
    
    func testFetchItems() {
        let expectation = self.expectation(description: "FetchItems")
        
        self.store.fetchItems(urlString: store.urlString, completionHandler: { (items,error) in
            self.jsonItems = items
            expectation.fulfill()
        })
        
        waitForExpectations(timeout: 3.0, handler: nil)
        XCTAssertTrue(jsonItems.count == 2)
    }
    
}
