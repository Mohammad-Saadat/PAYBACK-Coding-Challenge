//
//  DependencyContainer.swift
//  Space-X
//
//  Created by mohammad on 5/18/21.
//

import Foundation

public class DependencyContainer {
    lazy var networkManager: NetworkManagerProtocol = AppDelegate.getInstance().networkManager
    lazy var networkStateNotifier = AppDelegate.getInstance().networkStateNotifier
//    lazy var analyticsManager = AppDelegate.getInstance().analyticsManager
}

extension DependencyContainer {
//    func makeWindowManager() -> WindowManager {
//        return self.windowManager! // swiftlint:disable:this force_unwrapping
//    }
//
//    func makeAnalyticsManager() -> AnalyticsManager {
//        return self.analyticsManager! // swiftlint:disable:this force_unwrapping
//    }
}
