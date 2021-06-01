//
//  TokenProvider.swift
//  SHFTHeroV2
//
//  Created by mohammad on 5/18/21.
//

import Foundation
import PromiseKit

protocol TokenProviderProtocol {
    func fetchToken() -> String
}
