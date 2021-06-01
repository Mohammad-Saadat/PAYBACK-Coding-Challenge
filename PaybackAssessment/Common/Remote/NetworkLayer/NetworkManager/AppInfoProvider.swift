//
//  AppInfoProvider.swift
//  SHFTHeroV2
//
//  Created by mohammad on 5/18/21.
//
import Foundation

protocol AppInfoProviderProtocol {
    var apiKey: String? {get}
    var appVersion: String? {get}
}
