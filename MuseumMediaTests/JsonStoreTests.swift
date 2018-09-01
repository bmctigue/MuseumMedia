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
    
    var urlString = Constants.jsonUrl + "/\(MemStore.item.id)"
    var store: JsonStore!
    var jsonItem: Item!
    
    override func setUp() {
        self.store = JsonStore(urlString:urlString)
    }
    
    func testFetchItem() {
        let expectation = self.expectation(description: "FetchItem")
        
        self.store.fetchItem(urlString: store.urlString, completionHandler: { (item,error) in
            self.jsonItem = item
            expectation.fulfill()
        })
        
        waitForExpectations(timeout: 5.0, handler: nil)
        XCTAssertNotNil(jsonItem)
    }
}
