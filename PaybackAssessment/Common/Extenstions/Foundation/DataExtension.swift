//
//  DataExtension.swift
//  Space-X
//
//  Created by mohammad on 5/18/21.
//

import Foundation

extension Data {
    
    /// Converts this data to string with utf8 encoding
    var utf8String: String {
        guard let string = String(data: self, encoding: .utf8) else {
            fatalError("Could not convert data to string with encoding utf8")
        }
        return string
    }
    
}
