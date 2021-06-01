//
//  CustomNavigationController.swift
//  Space-X
//
//  Created by mohammad on 5/18/21.
//

import UIKit

class CustomNavigationController: UINavigationController {}

extension CustomNavigationController: RTAChangeRootProtocol {
    var preferredChangeRootTransitionStyle: RTAChangeRootTransitionStyle {
        return .none
    }
}
