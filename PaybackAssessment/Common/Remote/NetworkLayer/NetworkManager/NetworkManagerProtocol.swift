//
//  NetworkManagerProtocol.swift
//  MockFlash
//
//  Created by mohammad on 5/18/21.
//

import Foundation
import PromiseKit

protocol NetworkManagerProtocol {
    func request<Request: RequestProtocol, Response: Decodable>(_ request: Request) -> Promise<Response>
    func request<Request: RequestProtocol>(_ request: Request) -> Promise<Void>
}
