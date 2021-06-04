//
//  ShopListService.swift
//  PaybackAssessment
//
//  Created by mohammadSaadat on 3/14/1400 AP.
//  Copyright (c) 1400 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation
import PromiseKit

final class ShopListService {
    // MARK: - Object lifecycle
    init(networkManager: NetworkManagerProtocol, tileDataBaseManager: TileDataBaseManagerProtocol) {
        self.networkManager = networkManager
        self.tileDataBaseManager = tileDataBaseManager
        ShopListLogger.logInit(owner: String(describing: ShopListService.self))
    }
    
    // MARK: - Deinit
    deinit {
        ShopListLogger.logDeinit(owner: String(describing: ShopListService.self))
    }
    
    // MARK: - Properties
    
    // MARK: Private
    private let networkManager: NetworkManagerProtocol
    private let tileDataBaseManager: TileDataBaseManagerProtocol
}

// MARK: - Methods

// MARK: Public
extension ShopListService {
    func fetchItem(with id: String) -> Promise<Tile> {
        tileDataBaseManager.fetchTile(id: id)
    }
    
    func updateItem(with newTile: Tile) -> Promise<Tile> {
        tileDataBaseManager.updateTile(newTile: newTile)
    }
}
