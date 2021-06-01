//
//  InfoDictionary.swift
//  Space-X
//
//  Created by mohammad on 5/18/21.
//

import Foundation

final class InfoDictionary {
    // =============
    // MARK: - Enums
    // =============
    enum Key: String {
        case shortVersion = "CFBundleShortVersionString"
        case buildVersion = "CFBundleVersion"
        case displayName = "CFBundleDisplayName"
        case baseDomain = "Base Domain"
        case baseURL = "Base URL"
        case itunesURL = "iTunes URL"
        
        case privacyPolicyURL = "Privacy Policy URL"
    }
    
    // ==================
    // MARK: - Properties
    // ==================
    
    // MARK: Instance
    private let dictionary: [String: Any]!
    
    // MARK: Static
    static private(set) var main = InfoDictionary(Bundle.main.infoDictionary)
    
    init(_ dictionary: [String: Any]!) {
        self.dictionary = dictionary
    }
    
    // ==============
    // MARK: - Fields
    // ==============
    
    // MARK: Bundle version
    private(set) lazy var shortVersion: String = self.dictionary?[Key.shortVersion.rawValue] as? String ?? ""
    
    // MARK: Build version
    private(set) lazy var buildVersion: String = self.dictionary?[Key.buildVersion.rawValue] as? String ?? ""
    
    // MARK: App Name
    private(set) lazy var displayName: String = self.dictionary?[Key.displayName.rawValue] as? String ?? ""
    
    // MARK: Base Domain
    private(set) lazy var baseDomain: String = self.dictionary?[Key.baseDomain.rawValue] as? String ?? ""
    
    // MARK: Base URL
    private(set) lazy var baseURL: String = self.dictionary?[Key.baseURL.rawValue] as? String ?? ""
    
    // MARK: Privacy Policy URL
    private(set) lazy var privacyPolicyURL: String = self.dictionary[Key.privacyPolicyURL.rawValue] as? String ?? ""
}
