//
//  LaunchPage.swift
//  Space-X
//
//  Created by mohammadSaadat on 2/29/1400 AP.
//

import Foundation
import CoreData

// MARK: - TilesWrapper
struct TilesWrapper: Codable {
    let tiles: [RemoteTile]?
}

// MARK: - Tile
struct RemoteTile: Codable {
    let name: Name?
    let headline, subline: String?
    let data: String?
    let score: Int?
}

extension RemoteTile {
    func createTile(in context: NSManagedObjectContext) -> Tile {
        let tile = Tile(context: context)
        tile.name = self.name?.rawValue
        tile.data = self.data
        tile.headline = self.headline
        tile.subline = self.subline
        tile.score = "\(self.score ?? 0)"
        tile.id = UUID().uuidString
        return tile
    }
}


enum Name: String, Codable {
    case image
    case video
    case website
    case shoppingList
}
