//
//  WindowManager.swift
//  Space-X
//
//  Created by mohammad on 5/18/21.
//

import Foundation
import UIKit

public class WindowManager {
    public static var shared: WindowManager!
    let window: UIWindow?
    
    init(window: UIWindow?) {
        self.window = window
        WindowManager.shared = self
    }
    
    private func changeRootViewController(to viewController: (UIViewController & RTAChangeRootProtocol),
                                  animated: Bool? = nil,
                                  transitionStyle: RTAChangeRootTransitionStyle? = nil,
                                  duration: Double? = nil) {
        window?.changeRootViewController(to: viewController, animated: animated, transitionStyle: transitionStyle, duration: duration)
    }
    
    func changeRootToForceUpdateViewController(_ message: String, title: String = "Error".localized) {
        let vc = ForceUpdateViewController.init(forceUpdateMessage: message, forceUpdateTitle: title)
        let navigationController = CustomNavigationController(rootViewController: vc)
        changeRootViewController(to: navigationController)
    }
    
    func changeRootToSplash() {
//        let splashDependencyContainer = SplashDependencyContainer()
//
//        let splashViewController = CustomNavigationController(rootViewController: splashDependencyContainer.makeSplashViewController())
//        self.changeRootViewController(to: splashViewController)
    }
    
    func dismissAllViewControllers(_ animated: Bool) {
        window?.rootViewController?.dismiss(animated: animated, completion: nil)
    }
}

