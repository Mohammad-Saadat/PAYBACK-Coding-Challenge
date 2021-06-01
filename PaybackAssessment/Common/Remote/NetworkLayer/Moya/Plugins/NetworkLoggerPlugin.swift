//
//  NetworkLoggerPlugin.swift
//  MockFlash
//
//  Created by mohammad on 5/18/21.
//

import Moya

extension NetworkLoggerPlugin {
    static let `default`: NetworkLoggerPlugin = .init(configuration: .init(logOptions: [.requestBody, .formatRequestAscURL]))
}
