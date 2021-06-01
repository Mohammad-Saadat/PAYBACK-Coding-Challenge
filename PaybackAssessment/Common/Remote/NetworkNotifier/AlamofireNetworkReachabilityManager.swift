//
//  AlamofireNetworkReachabilityManager.swift
//  Space-X
//
//  Created by mohammad on 5/18/21.
//

import Alamofire

class AlamofireNetworkReachabilityManager {
    
    static let shared = AlamofireNetworkReachabilityManager()
    
    private lazy var reachabilityManager = Alamofire.NetworkReachabilityManager(host: "www.google.com")
    
    var isConnected: Bool {
        return reachabilityManager?.isReachable ?? false
    }
}

extension AlamofireNetworkReachabilityManager: NetworkNotifierProtocol {
    func startMonitoring() {}
    func statusChangeHandler(completionHandler: @escaping ((ConnectionType?, Bool) -> Void)) {
        let queue = DispatchQueue(label: "ReachabilityManagerListening")
        reachabilityManager?.startListening(onQueue: queue) { status in
            switch status {
            case .unknown:
                print("It is unknown whether the network is reachable")
                completionHandler(.unknown, self.isConnected)
            case .notReachable:
                print("It is notReachable the network is reachable")
                completionHandler(ConnectionType.none, self.isConnected)
            case .reachable(let value):
                switch value {
                case .ethernetOrWiFi:
                    print("The network is reachable over the EthernetOrWiFi connection")
                    completionHandler(.ethernetOrWiFi, self.isConnected)
                case .cellular:
                    print("The network is reachable over the Cellular connection")
                    completionHandler(.cellular, self.isConnected)
                }
            }
        }
    }
}

