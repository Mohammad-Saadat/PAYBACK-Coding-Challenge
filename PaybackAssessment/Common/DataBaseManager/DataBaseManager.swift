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

//class CoreDataService {
//    // MARK: - Object lifecycle
//    init(context: NSManagedObjectContext) {
//        self.context = context
//        debugPrint("LifeCycle ->" + String(describing: CoreDataService.self) + "init")
//        NotificationCenter.default.addObserver(self, selector: #selector(managedObjectContextDidSave), name: NSNotification.Name.NSManagedObjectContextDidSave, object: nil)
//
//    }
//
//    // MARK: - Deinit
//    deinit {
//        debugPrint("LifeCycle ->" + String(describing: CoreDataService.self) + "deinit")
//    }
//
//    // MARK: - Properties
//    weak private var delegate: CoreDataServiceDelegate?
//
//    // MARK: Private
//    private let context: NSManagedObjectContext
//}
//
//// MARK: Public
//extension CoreDataService {
//    func save(with venueRemotes: [VenueRemote]) throws {
//        self.configure(with: venueRemotes)
//        if context.hasChanges {
//            try context.save()
//        }
//    }
//
//    func deleteAllRecords() throws {
//        let deleteFetch: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest<NSFetchRequestResult>(entityName: "Venue")
//        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
//        try context.execute(deleteRequest)
//    }
//
//    func fetchAllData() throws -> [Venue] {
//        let fetchRequest: NSFetchRequest<Venue> = Venue.fetchRequest()
//        return try context.fetch(fetchRequest)
//    }
//
//    func setDelegate(with delegate: CoreDataServiceDelegate) {
//        self.delegate = delegate
//    }
//}
//
//private extension CoreDataService {
//    func configure(with venueRemotes: [VenueRemote]) {
//        for venueRemote in venueRemotes {
//            let place = Venue(context: self.context)
//            place.name = venueRemote.name
//            place.id = venueRemote.id
//            place.address = venueRemote.address
//            let category = venueRemote.categories?.first
//            place.categoryName = category?.name
//            place.categoryURL = category?.icon?.resourceString
//        }
//    }
//
//    @objc func managedObjectContextDidSave()  {
//        debugPrint("managedObjectContextDidSave")
//        let fetchRequest: NSFetchRequest<Venue> = Venue.fetchRequest()
//        if let places = try? context.fetch(fetchRequest) {
//            delegate?.fetchedDataAfterSaved(places: places)
//        }
//    }
//}
