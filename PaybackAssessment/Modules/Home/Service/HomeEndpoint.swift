//
//  HomeEndpoint.swift
//  PaybackAssessment
//
//  Created by mohammad on 6/2/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation

enum HomeEndpoint {
    case Tails(params: TailParams)
}

extension HomeEndpoint: RequestProtocol {
    
    public var relativePath: String {
        switch self {
        case .Tails: return "/b/payback-test.appspot.com/o/feed.json"
        }
    }
    
    public var method: HTTPMethod {
        switch self {
        case .Tails: return .get
        }
    }
    
    public var requestType: RequestType {
        switch self {
        case .Tails(let params):
            let urlParameters = ["alt": params.alt,
                                 "token": params.token]
            return .requestParameters(urlParameters: urlParameters, encoding: .queryString)
        }
    }
    
    public var headers: [String: String]? {
        return nil
    }
    
    var authorizationType: AuthType {
        return .none
    }
}
