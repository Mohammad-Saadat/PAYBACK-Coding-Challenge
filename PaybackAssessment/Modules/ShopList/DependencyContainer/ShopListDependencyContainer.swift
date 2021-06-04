//
//  ShopListDependencyContainer.swift
//  PaybackAssessment
//
//  Created by mohammadSaadat on 3/14/1400 AP.
//  Copyright (c) 1400 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation

class ShopListDependencyContainer: DependencyContainer {
    // MARK: - Object lifecycle
    override init() {
        ShopListLogger.logInit(owner: String(describing: ShopListDependencyContainer.self))
    }
    
    // MARK: - Deinit
    deinit {
        ShopListLogger.logDeinit(owner: String(describing: ShopListDependencyContainer.self))
    }
}

// MARK: - Factory
extension ShopListDependencyContainer: ShopListFactory {
    func makeShopListViewController(tileId: String) -> ShopListViewController {
        let vc = ShopListViewController(factory: self)
        vc.router?.dataStore?.tileId = tileId
        return vc
    }
    
    func setup(viewController: ShopListViewController) {
        guard viewController.interactor == nil else { return }
        let viewController = viewController
        let interactor = ShopListInteractor()
        let presenter = ShopListPresenter()
        let router = ShopListRouter()
        let worker = ShopListWorker(service: makeShopListService())
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        interactor.worker = worker
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    func makeShopListService() -> ShopListService {
        return ShopListService(networkManager: networkManager, tileDataBaseManager: tileDataBaseManager)
    }
}
