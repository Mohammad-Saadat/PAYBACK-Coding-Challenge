//
//  DataBaseManager.swift
//  PaybackAssessment
//
//  Created by mohammadSaadat on 3/11/1400 AP.
//

import Foundation
import CoreData
import PromiseKit

protocol DataBaseManagerProtocol {
    // MARK: CRUD operations - Optional error
    func fetchTiles() -> Promise<[Tile]>
    func fetchTile(id: String) -> Promise<Tile>
    func insert(remoteTiles: [RemoteTile]) -> Promise<[Tile]>
    func updateTile(newTile: Tile) -> Promise<Tile>
    func deleteOrder(id: String) -> Promise<Void>
}

enum TileStoreError: Error {
  case cannotFetch(String)
  case cannotCreate(String)
  case cannotUpdate(String)
  case cannotDelete(String)
}

extension NSManagedObjectContext: DataBaseManagerProtocol {
    func fetchTiles() -> Promise<[Tile]> {
        Promise { seal in
            let fetchRequest: NSFetchRequest<Tile> = Tile.fetchRequest()
            do {
                seal.fulfill(try self.fetch(fetchRequest))
            } catch {
                seal.reject(error)
            }
        }
    }
    
    func fetchTile(id: String) -> Promise<Tile> {
        Promise { seal in
            do {
                let fetchRequest: NSFetchRequest<Tile> = Tile.fetchRequest()
                fetchRequest.predicate = NSPredicate(format: "id == %@", id)
                let results = try self.fetch(fetchRequest)
                if let tail = results.first {
                    seal.fulfill(tail)
                }
            } catch {
                seal.reject(TileStoreError.cannotFetch(""))
            }
        }
    }
    
    func insert(remoteTiles: [RemoteTile]) -> Promise<[Tile]> {
        Promise { seal in
            do {
                let tiles = remoteTiles.map { $0.createTile(in: self) }
                if self.hasChanges {
                    try self.save()
                    seal.fulfill(tiles)
                }
            } catch {
                seal.reject(error)
            }
        }
    }
    
    func updateTile(newTile: Tile) -> Promise<Tile> {
        Promise { seal in
            do {
                let fetchRequest: NSFetchRequest<Tile> = Tile.fetchRequest()
                guard let id = newTile.id else { throw TileStoreError.cannotUpdate("Cannot find tile with id") }
                fetchRequest.predicate = NSPredicate(format: "id == %@", id)
                var results = try self.fetch(fetchRequest)
                if let tail = results.first {
                    results[0] = newTile
                    try self.save()
                    seal.fulfill(tail)
                }
            } catch {
                seal.reject(TileStoreError.cannotUpdate(""))
            }
        }
    }
    
    func deleteOrder(id: String) -> Promise<Void> {
        Promise { seal in
            do {
                let deleteFetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest<NSFetchRequestResult>(entityName: "Tile")
                let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetchRequest)
                try self.execute(deleteRequest)
                seal.fulfill(())
            } catch {
                seal.reject(error)
            }
        }
    }
}

extension NSManagedObjectContext {
    func mapToTileModel(with remoteTiles: [RemoteTile]) {
        for remoteTile in remoteTiles {
            let tile = Tile(context: self)
            tile.update(with: remoteTile)
            tile.id = UUID().uuidString
        }
    }
}

extension Tile {
    func update(with remoteTile: RemoteTile) {
        self.name = remoteTile.name?.rawValue
        self.data = remoteTile.data
        self.headline = remoteTile.headline
        self.subline = remoteTile.subline
        self.score = "\(remoteTile.score ?? 0)"
    }
}
