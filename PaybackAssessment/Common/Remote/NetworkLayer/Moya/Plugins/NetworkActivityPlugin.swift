//
//  NetworkActivityPlugin.swift
//  MockFlash
//
//  Created by mohammad on 5/18/21.
//

import Moya

extension NetworkActivityPlugin {
    static let `default`: NetworkActivityPlugin = .init { (networkActivityChangeType, _) in
        DispatchQueue.main.async {
            switch networkActivityChangeType {
            case .began:
                UIApplication.shared.isNetworkActivityIndicatorVisible = true
            case .ended:
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
            }
        }
    }
}
