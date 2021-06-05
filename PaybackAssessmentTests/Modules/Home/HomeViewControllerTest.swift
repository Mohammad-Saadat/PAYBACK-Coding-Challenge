//
//  HomeViewControllerTest.swift
//  PaybackAssessmentTests
//
//  Created by mohammadSaadat on 3/15/1400 AP.
//

import XCTest
import CoreData
@testable import PaybackAssessment

class HomeViewControllerTest: XCTestCase {
    
    var sut: HomeViewController!
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
    var window: UIWindow!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
        window = UIWindow()
        setupHomeViewController()
    }
    
    override func tearDownWithError() throws {
        window = nil
        sut = nil
        persistentContainer = nil
        super.tearDown()
    }
    
    // MARK: - Test setup
    
    func setupHomeViewController() {
        let homeDpendencyContainer = HomeDependencyContainer()
        sut = homeDpendencyContainer.makeHomeViewController()
    }
    
    func loadView() {
        window.addSubview(sut.view)
        RunLoop.current.run(until: Date())
    }
    
    // MARK: - interactor
    class HomeInteractorTest: HomeBusinessLogic {
        
        // MARK: Method call expectations
        
        var fetchDataCalled = false
        var refreshPageCalled = false
        
        // MARK: Business Logics methods
        
        func fetchData() {
            fetchDataCalled = true
        }
        
        func refreshPage() {
            refreshPageCalled = true
        }
    }
    
    // MARK: - tableView
    class HomeTableView: DefaultTableView {
        // MARK: Method call expectations
        
        var reloadDataCalled = false
        
        // MARK: reloadData method
        
        override func reloadData() {
            reloadDataCalled = true
        }
    }
    
    // MARK: - Tests
    func testShouldFetchLaunchDataWhenViewDidAppear() {
        // Given
        let homeInteractorTest = HomeInteractorTest()
        sut.interactor = homeInteractorTest
        loadView()
        
        // When
        sut.viewDidAppear(true)
        
        // Then
        XCTAssert(homeInteractorTest.fetchDataCalled, "Should fetch data right after the view appears")
        XCTAssert(!homeInteractorTest.refreshPageCalled, "Should not called refresh page right after the view appears")
    }
    
    func testShouldDisplayFetchedOrders() {
        // Given
        let homeTableView = HomeTableView(frame: CGRect(origin: .zero, size: .zero))
        sut.tableView = homeTableView
        
        // When
        let displayedTils = createTiles(in: persistentContainer.viewContext)
        let viewModelsCells = displayedTils.sorted(by: { ($0.score > $1.score) }).compactMap { ItemCellViewModel(tile: $0) }
        let section = DefaultSection(cells: viewModelsCells)
        let viewModel = Home.Item.ViewModel(sections: [section])
        sut.displayData(viewModel: viewModel)
        
        // Then
        XCTAssert(homeTableView.reloadDataCalled, "displayData should reload the table view")
    }
    
    func testNumberOfRowsInAnySectionShouldEqaulNumberOfTilesToDisplay() {
        // Given
        let homeTableView = HomeTableView(frame: CGRect(origin: .zero, size: .zero))
        sut.tableView = homeTableView
        
        let displayedTils = createTiles(in: persistentContainer.viewContext)
        let viewModelsCells = displayedTils.sorted(by: { ($0.score > $1.score) }).compactMap { ItemCellViewModel(tile: $0) }
        let section = DefaultSection(cells: viewModelsCells)
        let viewModel = Home.Item.ViewModel(sections: [section])
        sut.displayData(viewModel: viewModel)
        
        // When
        let numberOfRows = sut.tableView.numberOfRows(inSection: 0)
        
        // Then
        XCTAssertEqual(numberOfRows, displayedTils.count, "The number of table view rows should equal the number of Tile data")
    }
    
    func testShouldConfigureTableViewCellToDisplayTilesData() {
        // Given
        let homeTableView = HomeTableView(frame: CGRect(origin: .zero, size: .zero))
        sut.tableView = homeTableView
        
        let displayedTils = createTiles(in: persistentContainer.viewContext)
        let viewModelsCells = displayedTils.sorted(by: { ($0.score > $1.score) }).compactMap { ItemCellViewModel(tile: $0) }
        let section = DefaultSection(cells: viewModelsCells)
        let viewModel = Home.Item.ViewModel(sections: [section])
        sut.displayData(viewModel: viewModel)
        
        // When
        let indexPath = IndexPath(row: 0, section: 0)
        let cell = sut.tableView.dataSource?.tableView(sut.tableView, cellForRowAt: indexPath) as! ItemTableViewCell
        
        // Then
        XCTAssertEqual(cell.headLineLabel.text, "headline", "A properly configured table view cell should display the headline")
        XCTAssertEqual(cell.sublineLabel.text, "subline", "A properly configured table view cell should display the subline")
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
