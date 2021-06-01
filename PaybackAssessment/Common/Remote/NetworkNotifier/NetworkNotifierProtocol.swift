//
//  NetworkNotifierProtocol.swift
//  Space-X
//
//  Created by mohammad on 5/18/21.
//

import Foundation

protocol NetworkNotifierProtocol: class {
    func startMonitoring()
    func statusChangeHandler(completionHandler: @escaping ((ConnectionType?, Bool) -> Void))
    var isConnected: Bool { get }
}

protocol NetworkStateNotifierProtocol: class {
    func statusChangeHandler(connectionType: ConnectionType?, isConnected: Bool)
}
