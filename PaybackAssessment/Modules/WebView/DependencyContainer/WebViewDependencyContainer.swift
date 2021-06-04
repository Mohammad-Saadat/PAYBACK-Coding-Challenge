//
//  WebViewDependencyContainer.swift
//  TRB
//
//  Created by Farzad on 8/19/20.
//  Copyright (c) 2020 RoundTableApps. All rights reserved.
//

import Foundation

class WebViewDependencyContainer: DependencyContainer {
    // MARK: - Object lifecycle
    override init() {
        WebViewLogger.logInit(owner: String(describing: WebViewDependencyContainer.self))
    }
    
    // MARK: - Deinit
    deinit {
        WebViewLogger.logDeinit(owner: String(describing: WebViewDependencyContainer.self))
    }
}

// MARK: - Factory
extension WebViewDependencyContainer: WebViewFactory {
    func makeWebViewViewController(pageTitle: String, url: URL) -> WebViewViewController {
        let webViewVC = WebViewViewController(factory: self)
        var destinationDS = webViewVC.router?.dataStore
        destinationDS?.pageTitle = pageTitle
        destinationDS?.url = url
        return webViewVC
    }
    
    func setup(viewController: WebViewViewController) {
        guard viewController.interactor == nil else { return }
        let interactor = WebViewInteractor()
        let presenter = WebViewPresenter()
        let router = WebViewRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.webViewController = viewController
        router.dataStore = interactor
    }
}
