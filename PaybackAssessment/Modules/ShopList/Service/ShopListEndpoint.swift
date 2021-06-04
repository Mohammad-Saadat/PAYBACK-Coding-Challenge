//
//  ShopListEndpoint.swift
//  PaybackAssessment
//
//  Created by mohammadSaadat on 3/14/1400 AP.
//  Copyright (c) 1400 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation

enum ShopListEndpoint {
//    case something
}

extension ShopListEndpoint: RequestProtocol {
    
    public var relativePath: String {
//        switch self {
//        case .something: return "/"
//        }
        return "/"
    }
    
    public var method: HTTPMethod {
//        switch self {
//        case .something: return .get
//        }
        return .get
    }
    
    public var requestType: RequestType {
//        switch self {
//        case .something:
//            return .requestPlain
//        }
        return .requestPlain
    }
    
    public var headers: [String: String]? {
        return ["Content-Type": "application/json"]
    }
    
    var authorizationType: AuthType {
        return .bearer
    }
}
