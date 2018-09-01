//
//  ItemInteractorTests.swift
//  MuseumMediaTests
//
//  Created by Bruce McTigue on 8/18/18.
//  Copyright © 2018 tiguer. All rights reserved.
//

import XCTest
@testable import MuseumMedia

class TestViewController: ViewController {
    override func viewDidLoad() {
        // noop
    }
}

class ItemInteractorTests: XCTestCase {
    
    static let title = "Item one"
    static let imageUrl = "https://www.google.com"
    static let itemDescription = "Item one description"
    
    var item: Item!
    var sut: Interactor!
    let store = MemStore(urlString: nil)
    let viewController = ViewController()
    var presenter: PresentationLogic!
    
    override func setUp() {
        super.setUp()
        self.item = Item(title: ItemTests.title, imageUrl: ItemTests.imageUrl, itemDescription: ItemTests.itemDescription)
        self.presenter = Presenter(controller: tableViewController)
        self.sut = InteractorStub(presenter: presenter, store: store)
    }

    
    class InteractorStub: Interactor {
        override func fetchItems(request: MuseumMedia.FetchItems.Request) {
            worker?.fetchItems { (items) -> Void in
                let response = MuseumMedia.FetchItems.Response(items: items)
                self.presenter?.presentFetchedItems(response: response)
            }
        }
    }
    
    class PresentationLogicSpy: PresentationLogic {
        var presentFetchedItemsCalled = false
        func presentFetchedItems(response: MuseumMedia.FetchItems.Response) {
            presentFetchedItemsCalled = true
        }
    }
    
    class WorkerSpy: Worker {
        var fetchItemsCalled = false
        override func fetchItems(completionHandler: @escaping ([Item]) -> Void) {
            fetchItemsCalled = true
            completionHandler(MemStore.items)
        }
    }
    
    func testFetchItemsShouldAskWorkerToFetchItemsAndPresenterToFormatResult() {
        // Given
        let presentationLogicSpy = PresentationLogicSpy()
        sut.presenter = presentationLogicSpy
        let workerSpy = WorkerSpy(store: store)
        sut.worker = workerSpy
        
        // When
        let request = MuseumMedia.FetchItems.Request()
        sut.fetchItems(request: request)
        
        // Then
        XCTAssert(workerSpy.fetchItemsCalled, "FetchItems() should ask Worker to fetch items")
        XCTAssert(presentationLogicSpy.presentFetchedItemsCalled, "FetchItems() should ask presenter to format items result")
    }
}
