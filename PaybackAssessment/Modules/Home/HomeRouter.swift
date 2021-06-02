//
//  HomeRouter.swift
//  PaybackAssessment
//
//  Created by mohammad on 6/2/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

@objc protocol HomeRoutingLogic {
    //    func navigateToSomewhere()
}

protocol HomeDataPassing {
    var dataStore: HomeDataStore? { get }
}

class HomeRouter: NSObject, HomeDataPassing {
    // MARK: - Object lifecycle
    override init() {
        HomeLogger.logInit(owner: String(describing: HomeRouter.self))
    }
    
    // MARK: - Deinit
    deinit {
        HomeLogger.logDeinit(owner: String(describing: HomeRouter.self))
    }
    
    // MARK: - Properties
    
    // MARK: Public
    weak var viewController: HomeViewController?
    var dataStore: HomeDataStore?
}

// MARK: - Methods

// MARK: Private
private extension HomeRouter {}

// MARK: Public
extension HomeRouter {}

// MARK: - Routin Logic
extension HomeRouter: HomeRoutingLogic {
    // MARK: Navigation
}
