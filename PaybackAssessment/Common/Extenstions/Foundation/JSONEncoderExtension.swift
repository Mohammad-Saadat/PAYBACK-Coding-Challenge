//
//  JSONEncoderExtension.swift
//  Space-X
//
//  Created by mohammad on 5/18/21.
//

import Foundation

public extension JSONEncoder {
    /// Default JSONEncoder
    func getInstance() -> JSONEncoder {
//        dateEncodingStrategy = .iso8601
        keyEncodingStrategy = .convertToSnakeCase
        return self
    }
    
}
