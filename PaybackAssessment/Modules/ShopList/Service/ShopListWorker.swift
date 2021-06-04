//
//  ShopListWorker.swift
//  PaybackAssessment
//
//  Created by mohammadSaadat on 3/14/1400 AP.
//  Copyright (c) 1400 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import PromiseKit

protocol ShopListWorkerLogic {
    func fetchItem(with id: String) -> Promise<Tile>
    func updateItem(with newTile: Tile) -> Promise<Tile>
}

class ShopListWorker {
    // MARK: - Object lifecycle
    init(service: ShopListService) {
        ShopListLogger.logInit(owner: String(describing: ShopListWorker.self))
        self.service = service
    }
    
    // MARK: - Deinit
    deinit {
        ShopListLogger.logDeinit(owner: String(describing: ShopListWorker.self))
    }
    
    // MARK: - Properties
    
    // MARK: Private
    private let service: ShopListService
}

// MARK: - Methods

// MARK: Private
private extension ShopListWorker {}

// MARK: - Worker Logic
extension ShopListWorker: ShopListWorkerLogic {
    func fetchItem(with id: String) -> Promise<Tile> {
        service.fetchItem(with: id)
    }
    
    func updateItem(with newTile: Tile) -> Promise<Tile> {
        service.updateItem(with: newTile)
    }
}
