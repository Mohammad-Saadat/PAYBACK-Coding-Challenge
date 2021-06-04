//
//  ShopListPresenter.swift
//  PaybackAssessment
//
//  Created by mohammadSaadat on 3/14/1400 AP.
//  Copyright (c) 1400 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol ShopListPresentationLogic {
    func presentError(response: ShopList.ErrorModel.Response)
    func showLoading()
    func hideLoading()
    func presentData(response: ShopList.Add.Response)
}

class ShopListPresenter {
    // MARK: - Object lifecycle
    init() {
        ShopListLogger.logInit(owner: String(describing: ShopListPresenter.self))
    }
    
    // MARK: - Deinit
    deinit {
        ShopListLogger.logDeinit(owner: String(describing: ShopListPresenter.self))
    }
    
    // MARK: - Properties
    
    // MARK: Public
    weak var viewController: ShopListDisplayLogic?
}

// MARK: - Methods

// MARK: Private
private extension ShopListPresenter {
    func guaranteeMainThread(_ work: @escaping (() -> Void)) {
        if Thread.isMainThread {
            work()
        } else {
            DispatchQueue.main.async(execute: work)
        }
    }
}

// MARK: Public
extension ShopListPresenter {}

// MARK: - Presentation Logic
extension ShopListPresenter: ShopListPresentationLogic {
    func presentError(response: ShopList.ErrorModel.Response) {
        guaranteeMainThread {
            self.viewController?.displayError(viewModel: .init(error: response.error))
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
    
    func presentData(response: ShopList.Add.Response) {
        let viewModels = response.items.map { ShopListItemViewModel(item: $0) }
        let section = DefaultSection(cells: viewModels)
        guaranteeMainThread {
            self.viewController?.displayData(viewModel: .init(sections: [section]))
        }
    }
}
