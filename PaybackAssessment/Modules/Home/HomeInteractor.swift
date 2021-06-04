//
//  HomeInteractor.swift
//  PaybackAssessment
//
//  Created by mohammad on 6/2/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol HomeBusinessLogic {
    func fetchData()
    func refreshPage()
}

protocol HomeDataStore {}

class HomeInteractor: HomeDataStore {
    // MARK: - Object lifecycle
    init() {
        HomeLogger.logInit(owner: String(describing: HomeInteractor.self))
    }
    
    // MARK: - Deinit
    deinit {
        HomeLogger.logDeinit(owner: String(describing: HomeInteractor.self))
    }
    
    // MARK: - Properties
    
    // MARK: Public
    var presenter: HomePresentationLogic?
    var worker: HomeWorkerLogic?
}

// MARK: - Methods

// MARK: Private
private extension HomeInteractor {
    func refreshPage(tiles: [Tile]) {
        self.presenter?.presentData(response: .init(Tiles: tiles))
    }
    
    func presentError(_ error: Error) {
        self.presenter?.presentError(response: .init(error: error))
    }
    
    func hideLoadings() {
        self.presenter?.hideLoading()
        self.presenter?.hidePullToRefresh()
    }
}

// MARK: Public
extension HomeInteractor {}

// MARK: - Business Logics
extension HomeInteractor: HomeBusinessLogic {
    func fetchData() {
        presenter?.showLoading()
        worker?.getTails(params: TailParams())
            .done(refreshPage)
            .catch(presentError)
            .finally(hideLoadings)
    }
    
    func refreshPage() {
        worker?.refreshTails(params: TailParams())
            .done(refreshPage)
            .catch(presentError)
            .finally(hideLoadings)
    }
}
