//
//  RTAChangeRootProtocolExtension.swift
//  RTACore
//
//  Created by mohammad on 5/18/21.
//

import UIKit

public extension RTAChangeRootProtocol where Self: UIViewController {
    var prefersChangeRootAnimated: Bool {
        return true
    }
    var preferredChangeRootTransitionStyle: RTAChangeRootTransitionStyle {
        return .fadeIn
    }
    var preferredChangeRootTransitionDuration: Double {
        return 0.7
    }
}
