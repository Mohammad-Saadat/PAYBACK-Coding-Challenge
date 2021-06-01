//
//  RTAChangeRootSegue.swift
//  RTACore
//
//  Created by mohammad on 5/18/21.
//

import UIKit

open class RTAChangeRootSegue: UIStoryboardSegue {
    override open func perform() {
        guard let destination = destination as? (UIViewController & RTAChangeRootProtocol) else {
            fatalError("View controller \(self.destination) does not conform to protocol \"RTAChangeRootProtocol\"")
        }
        UIApplication.shared.keyWindow?.changeRootViewController(to: destination)
    }
}
