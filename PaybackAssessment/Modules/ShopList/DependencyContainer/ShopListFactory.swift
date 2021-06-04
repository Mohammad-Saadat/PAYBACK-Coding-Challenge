//
//  ShopListFactory.swift
//  PaybackAssessment
//
//  Created by mohammadSaadat on 3/14/1400 AP.
//  Copyright (c) 1400 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation

typealias ShopListFactory = ShopListViewControllerFactory & ShopListServiceFactory

protocol ShopListViewControllerFactory {
    func makeShopListViewController(tileId: String) -> ShopListViewController
    func setup(viewController: ShopListViewController)
}

protocol ShopListServiceFactory {
    func makeShopListService() -> ShopListService
}
