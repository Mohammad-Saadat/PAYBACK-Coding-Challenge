//
//  WebViewPresenter.swift
//  TRB
//
//  Created by Farzad on 8/19/20.
//  Copyright (c) 2020 RoundTableApps. All rights reserved.
//

import UIKit

protocol WebViewPresentationLogic {
    func presentWebViewPage(response: WebView.SetupWebKit.Response)
    func presentPageTitle(response: WebView.SetupWebKit.Response)
}

class WebViewPresenter {
    // MARK: - Object lifecycle
    init() {
        WebViewLogger.logInit(owner: String(describing: WebViewPresenter.self))
    }
    
    // MARK: - Deinit
    deinit {
        WebViewLogger.logDeinit(owner: String(describing: WebViewPresenter.self))
    }
    
    // MARK: - Properties
    
    // MARK: Public
    weak var viewController: WebViewDisplayLogic?
}

// MARK: - Methods

// MARK: Private
private extension WebViewPresenter {}

// MARK: Public
extension WebViewPresenter {}

// MARK: - Presentation Logic
extension WebViewPresenter: WebViewPresentationLogic {
    func presentPageTitle(response: WebView.SetupWebKit.Response) {
        let viewModel = WebView.SetupWebKit.ViewModel(url: response.url, pageTitle: response.pageTitle)
        viewController?.displayPageTitle(viewModel: viewModel)
    }
    
    func presentWebViewPage(response: WebView.SetupWebKit.Response) {
        let viewModel = WebView.SetupWebKit.ViewModel(url: response.url, pageTitle: response.pageTitle)
        viewController?.displayWebViewPage(viewModel: viewModel)
    }
}
