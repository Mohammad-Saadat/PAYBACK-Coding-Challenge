//
//  ShopListRouter.swift
//  PaybackAssessment
//
//  Created by mohammadSaadat on 3/14/1400 AP.
//  Copyright (c) 1400 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

@objc protocol ShopListRoutingLogic {
    //    func navigateToSomewhere()
}

protocol ShopListDataPassing {
    var dataStore: ShopListDataStore? { get set }
}

class ShopListRouter: NSObject, ShopListDataPassing {
    // MARK: - Object lifecycle
    override init() {
        ShopListLogger.logInit(owner: String(describing: ShopListRouter.self))
    }
    
    // MARK: - Deinit
    deinit {
        ShopListLogger.logDeinit(owner: String(describing: ShopListRouter.self))
    }
    
    // MARK: - Properties
    
    // MARK: Public
    weak var viewController: ShopListViewController?
    var dataStore: ShopListDataStore?
}

// MARK: - Methods

// MARK: Private
private extension ShopListRouter {}

// MARK: Public
extension ShopListRouter {}

// MARK: - Routin Logic
extension ShopListRouter: ShopListRoutingLogic {
    // MARK: Navigation
}
