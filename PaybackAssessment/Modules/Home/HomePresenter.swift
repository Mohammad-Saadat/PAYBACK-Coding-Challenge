//
//  HomePresenter.swift
//  PaybackAssessment
//
//  Created by mohammad on 6/2/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol HomePresentationLogic {
    func presentError(response: Home.ErrorModel.Response)
    func hidePullToRefresh()
    func showLoading()
    func hideLoading()
    func presentData(response: Home.Item.Response)
}

class HomePresenter {
    // MARK: - Object lifecycle
    init() {
        HomeLogger.logInit(owner: String(describing: HomePresenter.self))
    }
    
    // MARK: - Deinit
    deinit {
        HomeLogger.logDeinit(owner: String(describing: HomePresenter.self))
    }
    
    // MARK: - Properties
    
    // MARK: Public
    weak var viewController: HomeDisplayLogic?
}

// MARK: - Methods

// MARK: Private
// MARK: Private
private extension HomePresenter {
    func guaranteeMainThread(_ work: @escaping (() -> Void)) {
        if Thread.isMainThread {
            work()
        } else {
            DispatchQueue.main.async(execute: work)
        }
    }
}


// MARK: Public
extension HomePresenter {}

// MARK: - Presentation Logic
extension HomePresenter: HomePresentationLogic {
    func presentError(response: Home.ErrorModel.Response) {
        guaranteeMainThread {
            self.viewController?.displayError(viewModel: .init(error: response.error))
        }
    }
    
    func hidePullToRefresh() {
        guaranteeMainThread {
            self.viewController?.hidePullToRefresh()
        }
    }
    
    func showLoading() {
        guaranteeMainThread {
            self.viewController?.showLoading()
        }
    }
    
    func hideLoading() {
        guaranteeMainThread {
            self.viewController?.hideLoading()
        }
    }
    
    func presentData(response: Home.Item.Response) {
        let viewModels = response.Tiles.compactMap { ItemCellViewModel(tile: $0) }
        let section = DefaultSection(cells: viewModels)
        guaranteeMainThread {
            self.viewController?.displayData(viewModel: .init(sections: [section]))
        }
    }
}
