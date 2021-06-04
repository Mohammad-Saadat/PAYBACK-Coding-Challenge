//
//  WebViewFactory.swift
//  TRB
//
//  Created by Farzad on 8/19/20.
//  Copyright (c) 2020 RoundTableApps. All rights reserved.
//

import Foundation

typealias WebViewFactory = WebViewViewControllerFactory 

protocol WebViewViewControllerFactory {
    func makeWebViewViewController(pageTitle: String, url: URL) -> WebViewViewController
    func setup(viewController: WebViewViewController)
}
