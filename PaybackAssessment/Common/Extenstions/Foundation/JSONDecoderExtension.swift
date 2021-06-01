//
//  JSONDecoderExtension.swift
//  Space-X
//
//  Created by mohammad on 5/18/21.
//

import Foundation

public extension JSONDecoder {
    /// Default JSONDecoder
    func getInstance() -> JSONDecoder {
//        let formatter = DateFormatter()
//        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
//        formatter.calendar = Calendar(identifier: .iso8601)
//        dateDecodingStrategy = .formatted(formatter)
        keyDecodingStrategy = .convertFromSnakeCase
        return self
    }
}
