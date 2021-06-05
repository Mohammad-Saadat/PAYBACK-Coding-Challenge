//
//  ShopListPresenterTest.swift
//  PaybackAssessmentTests
//
//  Created by mohammadSaadat on 3/15/1400 AP.
//

import XCTest
import CoreData
@testable import PaybackAssessment

class ShopListPresenterTest: XCTestCase {
    
    var sut: ShopListPresenter!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
        setupShopListPresenter()
    }
    
    override func tearDownWithError() throws {
        sut = nil
        super.tearDown()
    }
    
    func setupShopListPresenter() {
        sut = ShopListPresenter()
    }
    
    // MARK: - DisplayLogic
    class ShopListDisplayLogicTest: ShopListDisplayLogic {
        // MARK: Method call expectations
        
        var sections = [SectionViewModel]()
        
        var displayErrorCalled = false
        var displayDataCalled = false
        var displayUpdateDataCalled = false
        var displayNextPageCalled = false
        
        // MARK: Display Logics methods
        func displayError(viewModel: ShopList.ErrorModel.ViewModel) {
            displayErrorCalled = true
        }
        
        func displayData(viewModel: ShopList.Add.ViewModel) {
            displayDataCalled = true
            sections = viewModel.sections
        }
        
        func showLoading() {}
        func hideLoading() {}
    }
    
    // MARK: - Tests
    func testPresentErrorShouldAskViewControllerToDisplayError() {
        // Given
        let homeDisplayLogicTest = ShopListDisplayLogicTest()
        sut.viewController = homeDisplayLogicTest
        
        // When
        sut.presentError(response: ShopList.ErrorModel.Response(error: NetworkErrors.connectionTimeout))
        
        // Then
        XCTAssert(homeDisplayLogicTest.displayErrorCalled, "Presenting error should ask view controller to display error")
    }
    
    func testPresentDataShouldAskViewControllerToDisplayData() {
        // Given
        let homeDisplayLogicTest = ShopListDisplayLogicTest()
        sut.viewController = homeDisplayLogicTest
        
        // When
        let items = ["item 1", "item 2", "item 3"]
        sut.presentData(response: ShopList.Add.Response(items: items))
        
        let cellModels = (homeDisplayLogicTest.sections[0].cells as! [ShopListItemViewModel]).map{ $0.getModel() } as! [String]
        
        // Then
        XCTAssertEqual(items.count, cellModels.count, "The number of sections in display logic should equal the number of Tile data")
        XCTAssert(homeDisplayLogicTest.displayDataCalled, "Presenting data should ask view controller to display data")
    }
}
