//
//  HomeService.swift
//  PaybackAssessment
//
//  Created by mohammad on 6/2/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation
import PromiseKit

final class HomeService {
    // MARK: - Object lifecycle
    init(networkManager: NetworkManagerProtocol, tileDataBaseManager: TileDataBaseManagerProtocol) {
        self.networkManager = networkManager
        self.tileDataBaseManager = tileDataBaseManager
        HomeLogger.logInit(owner: String(describing: HomeService.self))
    }
    
    // MARK: - Deinit
    deinit {
        HomeLogger.logDeinit(owner: String(describing: HomeService.self))
    }
    
    // MARK: - Properties
    
    // MARK: Private
    private let networkManager: NetworkManagerProtocol
    private let tileDataBaseManager: TileDataBaseManagerProtocol
}

// MARK: - Methods

// MARK: Public
extension HomeService {
    func getTails(params: TailParams) -> Promise<[Tile]> {
        if UserDefaults.standard.lastUpdateDate?.isDateInToday() ?? false {
            return tileDataBaseManager.fetchTiles()
        }
        return getRemoteTiles(params: params).then(saveRemoteTiles)
    }
    
    func refreshTails(params: TailParams) -> Promise<[Tile]> {
        return getRemoteTiles(params: params).then(saveRemoteTiles)
    }
}

private extension HomeService {
    func updateDate() {
        UserDefaults.standard.lastUpdateDate = Date()
    }
    
    func saveRemoteTiles(tilesWrapper: TilesWrapper) -> Promise<[Tile]> {
        updateDate()
        var data = [RemoteTile]()
        if let tiles = tilesWrapper.tiles, !tiles.isEmpty {
            data = tiles
        }
        return tileDataBaseManager.insert(remoteTiles: data)
    }
    
    func getRemoteTiles(params: TailParams) -> Promise<TilesWrapper> {
        self.networkManager
            .request(HomeEndpoint.Tails(params: params))
            .recover(NetworkErrors.parseError)
    }
}
