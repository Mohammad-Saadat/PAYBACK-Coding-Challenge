//
//  ShopListInteractor.swift
//  PaybackAssessment
//
//  Created by mohammadSaadat on 3/14/1400 AP.
//  Copyright (c) 1400 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol ShopListBusinessLogic {
    func fetchItem()
    func addToShopList(request: ShopList.Add.Request)
}

protocol ShopListDataStore {
    var tileId: String? { get set }
}

class ShopListInteractor: ShopListDataStore {
    // MARK: - Object lifecycle
    init() {
        ShopListLogger.logInit(owner: String(describing: ShopListInteractor.self))
    }
    
    // MARK: - Deinit
    deinit {
        ShopListLogger.logDeinit(owner: String(describing: ShopListInteractor.self))
    }
    
    // MARK: - Properties
    
    internal var tileId: String?
    private var tile: Tile?
    
    // MARK: Public
    var presenter: ShopListPresentationLogic?
    var worker: ShopListWorkerLogic?
}

// MARK: - Methods

// MARK: Private
private extension ShopListInteractor {
    func displayTile(tile: Tile) {
        self.tile = tile
        guard let items = tile.giveData() as? [String] else { return }
        self.presenter?.presentData(response: .init(items: items))
    }
    
    func presentError(_ error: Error) {
        self.presenter?.presentError(response: .init(error: error))
    }
    
    func hideLoadings() {
        self.presenter?.hideLoading()
    }
}

// MARK: Public
extension ShopListInteractor {}

// MARK: - Business Logics
extension ShopListInteractor: ShopListBusinessLogic {
    func fetchItem() {
        guard let tileId = self.tileId else { return }
        presenter?.showLoading()
        worker?.fetchItem(with: tileId)
            .done(displayTile)
            .catch(presentError)
            .finally(hideLoadings)
    }
    
    func addToShopList(request: ShopList.Add.Request) {
        guard let tile = self.tile else { return }
        var tileData = [String]()
        if let datas = self.tile?.giveData() as? [String] {
            tileData = datas
        }
        tileData.append(request.item)
        tile.data = tileData.joined(separator: ",")
        worker?.updateItem(with: tile)
            .done(displayTile)
            .catch(presentError)
            .finally(hideLoadings)
    }
}
