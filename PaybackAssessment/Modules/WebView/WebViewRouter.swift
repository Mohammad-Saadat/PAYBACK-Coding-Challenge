//
//  WebViewRouter.swift
//  TRB
//
//  Created by Farzad on 8/19/20.
//  Copyright (c) 2020 RoundTableApps. All rights reserved.
//

import UIKit

@objc protocol WebViewRoutingLogic {
    //    func navigateToSomewhere()
}

protocol WebViewDataPassing {
    var dataStore: WebViewDataStore? { get }
}

class WebViewRouter: NSObject, WebViewDataPassing {
    // MARK: - Object lifecycle
    override init() {
        WebViewLogger.logInit(owner: String(describing: WebViewRouter.self))
    }
    
    // MARK: - Deinit
    deinit {
        WebViewLogger.logDeinit(owner: String(describing: WebViewRouter.self))
    }
    
    // MARK: - Properties
    
    // MARK: Public
    weak var webViewController: WebViewViewController?
    var dataStore: WebViewDataStore?
}

// MARK: - Methods

// MARK: Private
private extension WebViewRouter {}

// MARK: Public
extension WebViewRouter {}

// MARK: - Routin Logic
extension WebViewRouter: WebViewRoutingLogic {
    // MARK: Navigation
}
