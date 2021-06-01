//
//  LaunchParams.swift
//  Space-X
//
//  Created by mohammadSaadat on 2/29/1400 AP.
//

import Foundation

struct LaunchParams: Encodable {
    // MARK: - Properties
    let options: Options
}

struct Options: Encodable {
    // MARK: - Properties
    let page: Int
    let limit: Int?
    
    static let defaultLimit = 10
}
