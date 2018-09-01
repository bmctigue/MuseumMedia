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
    
    var item: Item!
    var sut: Interactor!
    let store = MemStore(urlString: nil)
    let viewController = TestViewController()
    var presenter: PresentationLogic!
    
    override func setUp() {
        super.setUp()
        self.item = Item(id: MemStore.id, name: MemStore.name, url: MemStore.url, duration: MemStore.duration, quality: MemStore.quality)
        self.presenter = Presenter(controller: viewController)
        self.sut = InteractorStub(presenter: presenter, store: store)
    }

    
    class InteractorStub: Interactor {
        override func fetchItem(request: MuseumMedia.FetchItem.Request) {
            worker?.fetchItem { item -> Void in
                let response = MuseumMedia.FetchItem.Response(item: item)
                self.presenter?.presentFetchedItem(response: response)
            }
        }
        
        override func fetchMediaIds(request: MuseumMedia.FetchMediaIds.Request) {
            worker?.fetchMediaIds { mediaIds -> Void in
                let response = MuseumMedia.FetchMediaIds.Response(mediaIds: mediaIds)
                self.presenter?.updateFetchedMediaIds(response: response)
            }
        }
    }
    
    class PresentationLogicSpy: PresentationLogic {
        var presentFetchedItemCalled = false
        var updateMediaIdsCalled = true
        func updateFetchedMediaIds(response: MuseumMedia.FetchMediaIds.Response) {
            updateMediaIdsCalled = true
        }
        func presentFetchedItem(response: MuseumMedia.FetchItem.Response) {
            presentFetchedItemCalled = true
        }
    }
    
    class WorkerSpy: Worker {
        var fetchItemCalled = false
        var updateMediaItemsCalled = false
        override func fetchItem(completionHandler: @escaping (Item) -> Void) {
            fetchItemCalled = true
            completionHandler(MemStore.item)
        }
        override func fetchMediaIds(completionHandler: @escaping ([MediaId]) -> Void) {
            updateMediaItemsCalled = true
            completionHandler(MemStore.mediaIds)
        }
    }
    
    func testFetchItemsShouldAskWorkerToFetchItemAndPresenterToFormatResult() {
        // Given
        let presentationLogicSpy = PresentationLogicSpy()
        sut.presenter = presentationLogicSpy
        let workerSpy = WorkerSpy(store: store)
        sut.worker = workerSpy
        
        // When
        let request = MuseumMedia.FetchItem.Request(mediaId: MemStore.item.id)
        sut.fetchItem(request: request)
        
        // Then
        XCTAssert(workerSpy.fetchItemCalled, "FetchItem() should ask Worker to fetch item")
        XCTAssert(presentationLogicSpy.presentFetchedItemCalled, "FetchItem() should ask presenter to format item result")
    }
    
    func testFetchMediaIdsShouldAskWorkerToFetchMediaIdsAndUpdateMediaIds() {
        // Given
        let presentationLogicSpy = PresentationLogicSpy()
        sut.presenter = presentationLogicSpy
        let workerSpy = WorkerSpy(store: store)
        sut.worker = workerSpy
        
        // When
        let request = MuseumMedia.FetchMediaIds.Request()
        sut.fetchMediaIds(request: request)
        
        // Then
        XCTAssert(workerSpy.updateMediaItemsCalled, "FetchItem() should ask Worker to fetch item")
        XCTAssert(presentationLogicSpy.updateMediaIdsCalled, "FetchItem() should ask presenter to format item result")
    }
}
