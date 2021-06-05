//
//  ShopListInteractorTest.swift
//  PaybackAssessmentTests
//
//  Created by mohammadSaadat on 3/15/1400 AP.
//

import XCTest
import PromiseKit
import CoreData
@testable import PaybackAssessment

class ShopListInteractorTest: XCTestCase {
    
    var sut: ShopListInteractor!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
        setupHomeInteractor()
    }
    
    override func tearDownWithError() throws {
        sut = nil
        super.tearDown()
    }
    
    func setupHomeInteractor() {
        sut = ShopListInteractor()
    }
    
    // MARK: - presenter
    class ShopListPresentationLogicTest: ShopListPresentationLogic {
        
        // MARK: Method call expectations
        var presentDataCalled = false
        var presentErrorCalled = false
        
        // MARK: presenter Logics methods
        func presentError(response: ShopList.ErrorModel.Response) {
            presentErrorCalled = true
        }
        
        func hidePullToRefresh() {}
        func showLoading() {}
        func hideLoading() {}
        
        func presentData(response: ShopList.Add.Response) {
            presentDataCalled = true
        }
    }
    
    // MARK: - worker
    class ShopListWorkerLogicTest: ShopListWorkerLogic {
        
        lazy var persistentContainer: NSPersistentContainer = {
            let container = NSPersistentContainer(name: "PaybackAssessment")
            container.loadPersistentStores(completionHandler: { (storeDescription, error) in
                if let error = error as NSError? {
                    fatalError("Unresolved error \(error), \(error.userInfo)")
                }
                container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
            })
            return container
        }()
        
        // MARK: Method call expectations
        var fetchItemCalled = false
        var updateTileCalled = false
        
        func createTile(in context: NSManagedObjectContext) -> Tile {
            let first = Tile(context: context)
            first.name = "image"
            first.subline = "subline"
            first.headline = "headline"
            first.data = "image.png"
            first.score = 2
            
            return first
        }
        
        func fetchItem(with id: String) -> Promise<Tile> {
            Promise { seal in
                fetchItemCalled = true
                let data = createTile(in: persistentContainer.viewContext)
                seal.fulfill(data)
            }
        }
        
        func updateItem(with newTile: Tile) -> Promise<Tile> {
            Promise { seal in
                updateTileCalled = true
                seal.fulfill(newTile)
            }
        }
    }
    
    // MARK: - Tests
    func testFetchDataShouldAskHomeWorkerToGetTailAndPresenterTopresentData() {
        // Given
        let shopListPresentationLogicTest = ShopListPresentationLogicTest()
        sut.presenter = shopListPresentationLogicTest
        let shopListWorkerLogicTest = ShopListWorkerLogicTest()
        sut.worker = shopListWorkerLogicTest
        
        // When
        sut.fetchItem()
        
        // Then
        DispatchQueue.main.async {
            XCTAssert(shopListWorkerLogicTest.fetchItemCalled, "fetchItem() should ask worker to fetch Item Called")
            XCTAssert(shopListPresentationLogicTest.presentDataCalled, "fetchItem() should ask presenter to present data called")
        }
    }
    
    func testRefreshPageShouldAskHomeWorkerToRefreshTilAndPresenterTopresentData() {
        // Given
        let homePresentationLogicTest = ShopListPresentationLogicTest()
        sut.presenter = homePresentationLogicTest
        let homeWorkerLogicTest = ShopListWorkerLogicTest()
        sut.worker = homeWorkerLogicTest
        
        // When
        sut.addToShopList(request: .init(item: "test3"))
        
        // Then
        DispatchQueue.main.async {
            XCTAssert(homeWorkerLogicTest.updateTileCalled, "refreshPage() should ask worker to update Tile Called")
            XCTAssert(homePresentationLogicTest.presentDataCalled, "refreshPage() should ask presenter to present data called")
        }
    }
}
