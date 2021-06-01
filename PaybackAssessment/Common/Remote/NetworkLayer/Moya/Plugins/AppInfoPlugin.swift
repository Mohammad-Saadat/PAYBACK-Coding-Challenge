//
//  AppInfoPlugin.swift
//  MockFlash
//
//  Created by mohammad on 5/18/21.
//

import Moya

struct AppInfoPlugin: PluginType {
    let apiKey: String
    
    func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
        // Create temp request
        var request = request
        request.addValue(apiKey, forHTTPHeaderField: "x-api-key")
        
        // Adding platform and application information
        request.addValue("ios", forHTTPHeaderField: "App-Platform")
        request.addValue(InfoDictionary.main.shortVersion, forHTTPHeaderField: "App-Version")
        return request
    }
    
    func didReceive(_ result: Result<Response, MoyaError>, target: TargetType) {
        debugPrint("didReceive(_ result: Result<Response, MoyaError>, target: TargetType)")
    }
}
