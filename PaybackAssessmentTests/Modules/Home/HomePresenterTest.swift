//
//  HomePresenterTest.swift
//  PaybackAssessmentTests
//
//  Created by mohammadSaadat on 3/15/1400 AP.
//

import XCTest
import CoreData
@testable import PaybackAssessment

class HomePresenterTest: XCTestCase {
    
    var sut: HomePresenter!
    lazy var persistentContainer: NSPersistentContainer! = {
        let container = NSPersistentContainer(name: "PaybackAssessment")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
            container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        })
        return container
    }()
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
        setupHomePresenter()
    }
    
    override func tearDownWithError() throws {
        sut = nil
        persistentContainer = nil
        super.tearDown()
    }
    
    func setupHomePresenter() {
        sut = HomePresenter()
    }
    
    // MARK: - DisplayLogic
    class HomeDisplayLogicTest: HomeDisplayLogic {
        // MARK: Method call expectations
        
        var sections = [SectionViewModel]()
        
        var displayErrorCalled = false
        var displayDataCalled = false
        var displayUpdateDataCalled = false
        var displayNextPageCalled = false
        
        // MARK: Display Logics methods
        func displayError(viewModel: Home.ErrorModel.ViewModel) {
            displayErrorCalled = true
        }
        
        func hidePullToRefresh() {}
        func showLoading() {}
        func hideLoading() {}
        
        func displayData(viewModel: Home.Item.ViewModel) {
            displayDataCalled = true
            sections = viewModel.sections
        }
    }
    
    // MARK: - Tests
    func testPresentErrorShouldAskViewControllerToDisplayError() {
        // Given
        let homeDisplayLogicTest = HomeDisplayLogicTest()
        sut.viewController = homeDisplayLogicTest
        
        // When
        sut.presentError(response: Home.ErrorModel.Response(error: NetworkErrors.connectionTimeout))
        
        // Then
        XCTAssert(homeDisplayLogicTest.displayErrorCalled, "Presenting error should ask view controller to display error")
    }
    
    func testPresentDataShouldAskViewControllerToDisplayData() {
        // Given
        let homeDisplayLogicTest = HomeDisplayLogicTest()
        sut.viewController = homeDisplayLogicTest
        
        // When
        let data = createTiles(in: persistentContainer.viewContext)
        sut.presentData(response: Home.Item.Response(Tiles: data))
        
        let cellModels = (homeDisplayLogicTest.sections[0].cells as! [ItemCellViewModel]).map{ $0.getModel() } as! [Tile]
        
        // Then
        XCTAssertEqual(data.count, cellModels.count, "The number of sections in display logic should equal the number of Tile data")
        XCTAssertTrue(cellModels[0].score > cellModels[1].score, "Display the tile in the descending ranking order")
        XCTAssert(homeDisplayLogicTest.displayDataCalled, "Presenting data should ask view controller to display data")
    }
    
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
}
