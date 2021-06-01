//
//  RTAChangeRootProtocol.swift
//  RTACore
//
//  Created by mohammad on 5/18/21.
//

public protocol RTAChangeRootProtocol {
    /// Returns whether or not this view controller prefers animated change root
    var prefersChangeRootAnimated: Bool { get }
    /// Desired transition style for setting this view controller as root view controller
    var preferredChangeRootTransitionStyle: RTAChangeRootTransitionStyle { get }
    /// Desired duration time for setting this view controller as root view controller
    var preferredChangeRootTransitionDuration: Double { get }
}
