//
//  NetStatus.swift
//  Space-X
//
//  Created by mohammad on 5/18/21.
//

import Network

@available(iOS 12.0, *)

class NetStatus {
    
    // MARK: - Properties
    
    static let shared = NetStatus()
    
    var monitor: NWPathMonitor?
    
    var isMonitoring = false
    
    var didStartMonitoringHandler: (() -> Void)?
    
    var didStopMonitoringHandler: (() -> Void)?
    
    var netStatusChangeHandler: (() -> Void)?
    
    var isConnected: Bool {
        guard let monitor = monitor else { return false }
        return monitor.currentPath.status == .satisfied
    }
    
    var interfaceType: NWInterface.InterfaceType? {
        guard let monitor = monitor else { return nil }
        
        return monitor.currentPath.availableInterfaces.filter {
            monitor.currentPath.usesInterfaceType($0.type) }.first?.type
    }
    
    var availableInterfacesTypes: [NWInterface.InterfaceType]? {
        guard let monitor = monitor else { return nil }
        return monitor.currentPath.availableInterfaces.map { $0.type }
    }
    
    var isExpensive: Bool {
        return monitor?.currentPath.isExpensive ?? false
    }
    
    // MARK: - Init & Deinit
    
    private init() {
        
    }
    
    deinit {
        stopMonitoring()
    }
    
    // MARK: - Method Implementation
    
    func startMonitoring() {
        guard !isMonitoring else { return }
        
        monitor = NWPathMonitor()
        let queue = DispatchQueue(label: "NetStatus_Monitor")
        monitor?.start(queue: queue)
        
        monitor?.pathUpdateHandler = { result in
            self.netStatusChangeHandler?()
        }
        
        isMonitoring = true
        didStartMonitoringHandler?()
    }
    
    func stopMonitoring() {
        guard isMonitoring, let monitor = monitor else { return }
        monitor.cancel()
        self.monitor = nil
        isMonitoring = false
        didStopMonitoringHandler?()
    }
    
}

@available(iOS 12.0, *)
extension NetStatus: NetworkNotifierProtocol {
    func statusChangeHandler(completionHandler: @escaping ((ConnectionType?, Bool) -> Void)) {
        netStatusChangeHandler = { [weak self] in
            guard let `self` = self else { return }
            var connectionType: ConnectionType = .none
            if let currentInterfaceType = NetStatus.shared.interfaceType {
                switch currentInterfaceType {
                case .other:
                    connectionType = .other
                case .wifi:
                    connectionType = .wifi
                case .cellular:
                    connectionType = .cellular
                case .wiredEthernet:
                    connectionType = .wiredEthernet
                case .loopback:
                    connectionType = .loopback
                @unknown default:
                    connectionType = ConnectionType.none
                }
            }
            completionHandler(connectionType, self.isConnected)
        }
    }
}

