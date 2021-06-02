//
//  HomeDependencyContainer.swift
//  PaybackAssessment
//
//  Created by mohammad on 6/2/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation

class HomeDependencyContainer: DependencyContainer {
    // MARK: - Object lifecycle
    override init() {
        HomeLogger.logInit(owner: String(describing: HomeDependencyContainer.self))
    }
    
    // MARK: - Deinit
    deinit {
        HomeLogger.logDeinit(owner: String(describing: HomeDependencyContainer.self))
    }
}

// MARK: - Factory
extension HomeDependencyContainer: HomeFactory {
    func makeHomeViewController() -> HomeViewController {
        HomeViewController(factory: self)
    }
    
    func setup(viewController: HomeViewController) {
        guard viewController.interactor == nil else { return }
        let interactor = HomeInteractor()
        let presenter = HomePresenter()
        let router = HomeRouter()
        let worker = HomeWorker(service: makeHomeService())
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        interactor.worker = worker
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    func makeHomeService() -> HomeService {
        HomeService(networkManager: networkManager, tileDataBaseManager: tileDataBaseManager)
    }
}
