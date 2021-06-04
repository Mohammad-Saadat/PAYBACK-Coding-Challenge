//
//  WebViewInteractor.swift
//  TRB
//
//  Created by Farzad on 8/19/20.
//  Copyright (c) 2020 RoundTableApps. All rights reserved.
//

import UIKit

protocol WebViewBusinessLogic {
    func viewDidLoad(request: WebView.SetupWebKit.Request)
}

protocol WebViewDataStore {
    var url: URL? { get set }
    var pageTitle: String? { get set }
}

class WebViewInteractor: WebViewDataStore {
    var url: URL?
    
    var pageTitle: String?
    
    // MARK: - Object lifecycle
    init() {
        WebViewLogger.logInit(owner: String(describing: WebViewInteractor.self))
    }
    
    // MARK: - Deinit
    deinit {
        WebViewLogger.logDeinit(owner: String(describing: WebViewInteractor.self))
    }
    
    // MARK: - Properties
    
    // MARK: Public
    var presenter: WebViewPresentationLogic?
}

// MARK: - Methods

// MARK: Private
private extension WebViewInteractor {}

// MARK: Public
extension WebViewInteractor {}

// MARK: - Business Logics
extension WebViewInteractor: WebViewBusinessLogic {
    func viewDidLoad(request: WebView.SetupWebKit.Request) {
        guard let url = url else {
            fatalError()
        }
        let response = WebView.SetupWebKit.Response(url: url, pageTitle: pageTitle ?? "")
        presenter?.presentWebViewPage(response: response)
        presenter?.presentPageTitle(response: response)
    }
}
