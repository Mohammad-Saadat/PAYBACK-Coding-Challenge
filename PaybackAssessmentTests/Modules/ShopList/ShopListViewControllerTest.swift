//
//  ShopListViewControllerTest.swift
//  PaybackAssessmentTests
//
//  Created by mohammadSaadat on 3/15/1400 AP.
//

import XCTest
import CoreData
@testable import PaybackAssessment

class ShopListViewControllerTest: XCTestCase {
    
    var sut: ShopListViewController!
    var window: UIWindow!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
        window = UIWindow()
        setupShopListViewController()
    }
    
    override func tearDownWithError() throws {
        window = nil
        sut = nil
        super.tearDown()
    }
    
    // MARK: - Test setup
    
    func setupShopListViewController() {
        let homeDpendencyContainer = ShopListDependencyContainer()
        sut = homeDpendencyContainer.makeShopListViewController(tileId: "1")
        
    }
    
    func loadView() {
        window.addSubview(sut.view)
        RunLoop.current.run(until: Date())
    }
    
    // MARK: - interactor
    class ShopListInteractorTest: ShopListBusinessLogic {
        
        // MARK: Method call expectations
        
        var fetchItemCalled = false
        var addToShopListCalled = false
        
        // MARK: Business Logics methods
        
        func fetchItem() {
            fetchItemCalled = true
        }
        
        func addToShopList(request: ShopList.Add.Request) {
            addToShopListCalled = true
        }
    }
    
    // MARK: - tableView
    class ShopListTableView: DefaultTableView {
        // MARK: Method call expectations
        
        var reloadDataCalled = false
        
        // MARK: reloadData method
        
        override func reloadData() {
            reloadDataCalled = true
        }
    }
    
    // MARK: - Tests
    func testShouldFetchItemWhenViewDidAppear() {
        // Given
        let homeInteractorTest = ShopListInteractorTest()
        sut.interactor = homeInteractorTest
        
        // When
        sut.viewDidLoad()
        
        // Then
        XCTAssert(homeInteractorTest.fetchItemCalled, "Should fetch Item right after the view appears")
        XCTAssert(!homeInteractorTest.addToShopListCalled, "Should not called add to shop list right after the view appears")
    }
    
    // MARK: - Tests
    func testShouldNotCalledAddToShopList() {
        // Given
        let homeInteractorTest = ShopListInteractorTest()
        sut.interactor = homeInteractorTest
        
        // When
        let textField =  UITextField()
        sut.itemTextField = textField
        sut.itemTextField.text = ""
        sut.rightButton.sendActions(for: .touchUpInside)
        
        // Then
        XCTAssert(!homeInteractorTest.addToShopListCalled, "Should not called add to shop list when itemTextField is empty")
    }
    
    // MARK: - Tests
    func testShouldCalledAddToShopList() {
        // Given
        let homeInteractorTest = ShopListInteractorTest()
        sut.interactor = homeInteractorTest
        let textField =  UITextField()
        sut.itemTextField = textField
        
        // When
        sut.itemTextField.text = "test2"
        sut.rightButton.sendActions(for: .touchUpInside)
        
        // Then
        XCTAssert(homeInteractorTest.addToShopListCalled, "Should  called add to shop list when itemTextField is not empty")
        XCTAssertEqual(sut.itemTextField.text, "", "itemTextField text should became empty after rightButton tapped")
    }
    
    func testShouldDisplayFetchedOrders() {
        // Given
        let homeTableView = ShopListTableView(frame: CGRect(origin: .zero, size: .zero))
        sut.tableView = homeTableView
        
        // When
        let items = ["item 1", "item 2", "item 3"]
        let viewModels = items.map { ShopListItemViewModel(item: $0) }
        let section = DefaultSection(cells: viewModels)
        let viewModel = ShopList.Add.ViewModel(sections: [section])
        sut.displayData(viewModel: viewModel)
        
        // Then
        XCTAssert(homeTableView.reloadDataCalled, "displayData should reload the table view")
    }
    
    func testNumberOfRowsInAnySectionShouldEqaulNumberOfShopListItemToDisplay() {
        // Given
        let homeTableView = ShopListTableView(frame: CGRect(origin: .zero, size: .zero))
        sut.tableView = homeTableView
        
            let items = ["item 1", "item 2", "item 3"]
            let viewModels = items.map { ShopListItemViewModel(item: $0) }
            let section = DefaultSection(cells: viewModels)
            let viewModel = ShopList.Add.ViewModel(sections: [section])
            sut.displayData(viewModel: viewModel)
        
        // When
        let numberOfRows = sut.tableView.numberOfRows(inSection: 0)
        
        // Then
        XCTAssertEqual(numberOfRows, items.count, "The number of table view rows should equal the number of shopList item")
    }
    
    func testShouldConfigureTableViewCellToDisplayLaunchData() {
        // Given
        let homeTableView = ShopListTableView(frame: CGRect(origin: .zero, size: .zero))
        sut.tableView = homeTableView
        
        let items = ["item 1", "item 2", "item 3"]
        let viewModels = items.map { ShopListItemViewModel(item: $0) }
        let section = DefaultSection(cells: viewModels)
        let viewModel = ShopList.Add.ViewModel(sections: [section])
        sut.displayData(viewModel: viewModel)
        
        // When
        let indexPath = IndexPath(row: 0, section: 0)
        let cell = sut.tableView.dataSource?.tableView(sut.tableView, cellForRowAt: indexPath) as! ShopListTableViewCell
        
        // Then
        XCTAssertEqual(cell.itemLabel.text, "item 1", "A properly configured table view cell should display the itemLabel")
    }
}
