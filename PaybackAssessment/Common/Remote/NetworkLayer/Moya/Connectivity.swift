//
//  Connectivity.swift
//  TRB
//
//  Created by mohammad on 5/18/21.
//

import Foundation
import Alamofire

class Connectivity {
    class var isConnectedToInternet: Bool {
        return NetworkReachabilityManager()?.isReachable ?? false
    }
}
