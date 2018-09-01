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
    var itemUrlString = Constants.jsonUrl + "/\(MemStore.item.id)"
    var store: JsonStore!
    var mediaIds: [MediaId] = []
    var jsonItem: Item!
    
    func testFetchMediaIds() {
        self.mediaIds = []
        self.store = JsonStore(urlString: nil)
        store.urlString = Constants.jsonUrl
        let expectation = self.expectation(description: "FetchMediaIds")
        
        self.store.fetchMediaIds(urlString: store.urlString, completionHandler: { (mediaIds,error) in
            self.mediaIds = mediaIds
            expectation.fulfill()
        })
        
        waitForExpectations(timeout: 5.0, handler: nil)
        XCTAssertTrue(self.mediaIds.count > 0)
    }
}
