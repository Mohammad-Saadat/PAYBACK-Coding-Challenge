//
//  HomeIntercatorTest.swift
//  PaybackAssessmentTests
//
//  Created by mohammadSaadat on 3/15/1400 AP.
//

import XCTest
import PromiseKit
import CoreData
@testable import PaybackAssessment

class HomeIntercatorTest: XCTestCase {
    
    var sut: HomeInteractor!
    
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
        sut = HomeInteractor()
    }
    
    // MARK: - presenter
    class HomePresentationLogicTest: HomePresentationLogic {
        
        // MARK: Method call expectations
        var presentDataCalled = false
        var presentRefreshTailsCalled = false
        var presentErrorCalled = false
        
        // MARK: presenter Logics methods
        func presentError(response: Home.ErrorModel.Response) {
            presentErrorCalled = true
        }
        
        func hidePullToRefresh() {}
        func showLoading() {}
        func hideLoading() {}
        
        func presentData(response: Home.Item.Response) {
            presentDataCalled = true
            presentRefreshTailsCalled = true
        }
    }
    
    // MARK: - worker
    class HomeWorkerLogicTest: HomeWorkerLogic {
        
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
        var getTileCalled = false
        var refreshTileCalled = false
        
        func createTiles(in context: NSManagedObjectContext) -> [Tile] {
            let first = Tile(context: context)
            first.name = "image"
            first.subline = "subline"
            first.headline = "headline"
            first.data = "image.png"
            first.score = 2
            
            let second = Tile(context: context)
            second.name = "website"
            second.subline = "subline"
            second.headline = "headline"
            second.data = "google.com"
            second.score = 1
            
            return [first, second]
        }
        
        func getTails(params: TailParams) -> Promise<[Tile]> {
            Promise { seal in
                getTileCalled = true
                let data = createTiles(in: persistentContainer.viewContext)
                seal.fulfill(data)
            }
        }
        
        func refreshTails(params: TailParams) -> Promise<[Tile]> {
            Promise { seal in
                refreshTileCalled = true
                let data = createTiles(in: persistentContainer.viewContext)
                seal.fulfill(data)
            }
        }
    }
    
    // MARK: - Tests
    func testFetchDataShouldAskHomeWorkerToGetTailAndPresenterTopresentData() {
        // Given
        let homePresentationLogicTest = HomePresentationLogicTest()
        sut.presenter = homePresentationLogicTest
        let homeWorkerLogicTest = HomeWorkerLogicTest()
        sut.worker = homeWorkerLogicTest
        
        // When
        sut.fetchData()
        
        // Then
        DispatchQueue.main.async {
            XCTAssert(homeWorkerLogicTest.getTileCalled, "fetchData() should ask worker to fetch data Called")
            XCTAssert(homePresentationLogicTest.presentDataCalled, "fetchData() should ask presenter to present data called")
        }
    }
    
    func testRefreshPageShouldAskHomeWorkerToRefreshTilAndPresenterTopresentData() {
        // Given
        let homePresentationLogicTest = HomePresentationLogicTest()
        sut.presenter = homePresentationLogicTest
        let homeWorkerLogicTest = HomeWorkerLogicTest()
        sut.worker = homeWorkerLogicTest
        
        // When
        sut.refreshPage()
        
        // Then
        DispatchQueue.main.async {
            XCTAssert(homeWorkerLogicTest.refreshTileCalled, "refreshPage() should ask worker to refreshTails Called")
            XCTAssert(homePresentationLogicTest.presentRefreshTailsCalled, "refreshPage() should ask presenter to present data called")
        }
    }
}
