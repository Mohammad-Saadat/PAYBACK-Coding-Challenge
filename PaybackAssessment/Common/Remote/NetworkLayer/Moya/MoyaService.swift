//
//  MoyaService.swift
//  MockFlash
//
//  Created by mohammad on 5/18/21.
//

import Moya

class MoyaService<TargetType: Moya.TargetType> {
    // ==================
    // MARK: - Properties
    // ==================
    let jsonDecoder: JSONDecoder
    let tokenProvider: TokenProviderProtocol
    let appInfoProvider: AppInfoProviderProtocol
    let tokenPlugin: AccessTokenPlugin
    
    init(jsonDecoder: JSONDecoder, tokenProvider: TokenProviderProtocol, appInfoProvider: AppInfoProviderProtocol) {
        self.jsonDecoder = jsonDecoder
        self.tokenProvider = tokenProvider
        self.appInfoProvider = appInfoProvider
        self.tokenPlugin = AccessTokenPlugin { [tokenProvider] _ in
            return tokenProvider.fetchToken()
        }
    }
    /// Moya Provider
    lazy var provider = CustomMoyaProvider<TargetType>(jsonDecoder: jsonDecoder, plugins: [
        NetworkLoggerPlugin.default,
        NetworkActivityPlugin.default,
        AppInfoPlugin(apiKey: self.appInfoProvider.apiKey ?? ""),
        self.tokenPlugin,
        GeneralErrorHandlerPlugin.default
        ])
    
    lazy var stubProvider = CustomMoyaProvider<TargetType>(jsonDecoder: jsonDecoder, stubClosure: { _ -> StubBehavior in
        return .delayed(seconds: 2.0)
    }, plugins: [
        NetworkLoggerPlugin.default,
        NetworkActivityPlugin.default,
        AppInfoPlugin(apiKey: self.appInfoProvider.apiKey ?? ""),
        self.tokenPlugin,
        GeneralErrorHandlerPlugin.default
    ])
}
