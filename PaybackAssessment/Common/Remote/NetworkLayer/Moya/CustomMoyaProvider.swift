//
//  MoyaExtention.swift
//  MockFlash
//
//  Created by mohammad on 5/18/21.
//

import Foundation
import PromiseKit
import Moya

class CustomMoyaProvider<T: TargetType>: MoyaProvider<T> {
    
    let jsonDecoder: JSONDecoder
    
    public init(jsonDecoder: JSONDecoder = JSONDecoder(),
                endpointClosure: @escaping EndpointClosure = MoyaProvider.defaultEndpointMapping,
                requestClosure: @escaping RequestClosure = MoyaProvider<Target>.defaultRequestMapping,
                stubClosure: @escaping StubClosure = MoyaProvider.neverStub,
                callbackQueue: DispatchQueue? = nil,
                session: Session = MoyaProvider<Target>.defaultAlamofireSession(),
                plugins: [PluginType] = [],
                trackInflights: Bool = false) {
        self.jsonDecoder = jsonDecoder
        super.init(endpointClosure: endpointClosure, requestClosure: requestClosure, stubClosure: stubClosure, callbackQueue: callbackQueue, session: session, plugins: plugins, trackInflights: trackInflights)
    }
    
    func request(_ target: Target, callbackQueue: DispatchQueue? = .none, progress: ProgressBlock? = .none) -> Promise<Void> {
        return Promise { seal in
            request(
                target,
                callbackQueue: callbackQueue,
                progress: progress
            ) { result in
                do {
                    _ = try result.get()
                    seal.fulfill(())
                } catch {
                    seal.reject(error)
                }
            }
        }
    }
    
    func request<T: Decodable>(_ target: Target, callbackQueue: DispatchQueue? = .none, progress: ProgressBlock? = .none) -> Promise<T> {
        return Promise { [jsonDecoder] seal in
            request(
                target,
                callbackQueue: callbackQueue,
                progress: progress
            ) { result in
                do {
                    let response = try result.get()
                    seal.fulfill(try response.map(T.self, using: jsonDecoder))
                } catch {
                    seal.reject(error)
                }
            }
        }
    }
}

extension TargetType {
    var validationType: ValidationType {
        return .successCodes
    }
}
