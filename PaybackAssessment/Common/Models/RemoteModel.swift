//
//  LaunchPage.swift
//  Space-X
//
//  Created by mohammadSaadat on 2/29/1400 AP.
//

import Foundation
import CoreData
import UIKit

// MARK: - TilesWrapper
struct TilesWrapper: Codable {
    let tiles: [RemoteTile]?
}

// MARK: - Tile
struct RemoteTile: Codable {
    let name: Name?
    let headline, subline: String?
    let data: String?
    let score: Int
}

extension RemoteTile {
    func createTile(in context: NSManagedObjectContext) -> Tile {
        let tile = Tile(context: context)
        tile.name = self.name?.rawValue
        tile.data = self.data
        tile.headline = self.headline
        tile.subline = self.subline
        tile.score = Int64(self.score)
        tile.id = UUID().uuidString
        return tile
    }
}

extension Tile {
    func giveData() -> Any? {
        guard let data = self.data else { return nil }
        guard let name = self.giveName() else { return nil }
        switch name {
        case .image, .video, .website:
            return URL(string: data)
        case .shoppingList:
            return data.components(separatedBy: ",")
        }
    }
    
    func giveName() -> Name? {
        guard let nameString = self.name else { return nil }
        guard let name = Name(rawValue: nameString)  else { return nil }
        return name
    }
    
    func giveImage() -> UIImage? {
        guard let name = self.giveName() else { return nil }
        switch name {
        case .image:
            return #imageLiteral(resourceName: "Picture")
        case .video:
            return #imageLiteral(resourceName: "video")
        case .website:
            return #imageLiteral(resourceName: "website")
        case .shoppingList:
            return #imageLiteral(resourceName: "shopList")
        }
    }
    
    func giveDescription() -> String? {
        guard let name = self.giveName() else { return nil }
        switch name {
        case .image:
            return "image exist in detail page"
        case .video:
            return "video exist in detail page"
        case .website:
            return "there is nice web view in detail page"
        case .shoppingList:
            return "you can see your list in detail page"
        }
    }
}

enum Name: String, Codable {
    case image
    case video
    case website
    case shoppingList = "shopping_list"
}
