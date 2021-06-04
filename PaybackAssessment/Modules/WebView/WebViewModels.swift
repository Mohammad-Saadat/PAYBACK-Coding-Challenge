//
//  WebViewModels.swift
//  TRB
//
//  Created by Farzad on 8/19/20.
//  Copyright (c) 2020 RoundTableApps. All rights reserved.
//

import UIKit

enum WebView {
    // MARK: Use cases
    
    enum SetupWebKit {
        struct Request {
        }
        struct Response {
            var url: URL
            var pageTitle: String
        }
        struct ViewModel {
            var url: URL
            var pageTitle: String
        }
    }
}
