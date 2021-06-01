//
//  NetworkStateNotifier.swift
//  Space-X
//
//  Created by mohammad on 5/18/21.
//

import Foundation

/// Defines the various connection types detected by reachability flags.
public enum ConnectionType {
    
    /// A virtual or otherwise unknown interface type
    case other
    
    /// A Wi-Fi link
    case wifi
    
    /// A Cellular link
    case cellular
    
    /// A Wired Ethernet link
    case wiredEthernet
    
    /// The Loopback Interface
    case loopback
    
    /// The connection type is either over Ethernet or WiFi.
    case ethernetOrWiFi
    
    case none
    
    case unknown
}

class NetworkStateNotifier {
    
    static let share = NetworkStateNotifier()
    
    weak var networkNotifierProtocol: NetworkNotifierProtocol?
    weak var delegate: NetworkStateNotifierProtocol?
    
    private var connectionType: ConnectionType?
    var isConnected: Bool {
        networkNotifierProtocol?.isConnected ?? false
    }
    
    init() {
        if #available(iOS 12.0, *) {
            networkNotifierProtocol = NetStatus.shared
            networkNotifierProtocol?.startMonitoring()
        } else {
            networkNotifierProtocol = AlamofireNetworkReachabilityManager.shared
        }
        networkNotifierProtocol?.statusChangeHandler { (connectionType, isConnected) in
            self.delegate?.statusChangeHandler(connectionType: connectionType, isConnected: isConnected)
        }
    }
}

