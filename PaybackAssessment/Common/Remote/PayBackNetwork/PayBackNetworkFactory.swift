//
//  SpaceXNetworkFactory.swift
//  Space-X
//
//  Created by mohammad on 5/18/21.
//

import Foundation
import PromiseKit

protocol NetworkManagerFactoryType {
    func createNetworkManager() -> NetworkManagerProtocol
}

struct NetworkManagerFactory: NetworkManagerFactoryType {
    func createNetworkManager() -> NetworkManagerProtocol {
        
        let networkManager = NetworkManager(tokenProvider: TokenProvider(), appInfoProvider: AppInfoProvider())
        return networkManager
    }
}

struct TokenProvider: TokenProviderProtocol {
    init() {}
    
    func fetchToken() -> String {
        return ""
    }
}

struct AppInfoProvider: AppInfoProviderProtocol {
    var apiKey: String? {
        return ""
    }
    
    var appVersion: String? {
        return InfoDictionary.main.shortVersion
    }
}
