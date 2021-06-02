//
//  UserDefaultsExtension.swift
//  PaybackAssessment
//
//  Created by mohammad on 6/2/21.
//

import Foundation

enum UserDefaultsKeys: String {
    case lastUpdateDate
}

extension UserDefaults {
    var lastUpdateDate: Date? {
        get {
            return (object(forKey: UserDefaultsKeys.lastUpdateDate.rawValue) as? Date)
        }
        set {
            set(newValue, forKey: UserDefaultsKeys.lastUpdateDate.rawValue)
        }
    }
}
