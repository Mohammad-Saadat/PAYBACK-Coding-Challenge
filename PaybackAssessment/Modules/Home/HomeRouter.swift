//
//  HomeRouter.swift
//  PaybackAssessment
//
//  Created by mohammad on 6/2/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import AVKit

protocol HomeRoutingLogic {
    func navigateToDetailViewController(model: Tile)
}

protocol HomeDataPassing {
    var dataStore: HomeDataStore? { get }
}

class HomeRouter: NSObject, HomeDataPassing {
    // MARK: - Object lifecycle
    override init() {
        HomeLogger.logInit(owner: String(describing: HomeRouter.self))
    }
    
    // MARK: - Deinit
    deinit {
        HomeLogger.logDeinit(owner: String(describing: HomeRouter.self))
    }
    
    // MARK: - Properties
    
    // MARK: Public
    weak var viewController: HomeViewController?
    var dataStore: HomeDataStore?
}

// MARK: - Methods

// MARK: Private
private extension HomeRouter {}

// MARK: Public
extension HomeRouter {}

// MARK: - Routin Logic
extension HomeRouter: HomeRoutingLogic {
    // MARK: Navigation
    func navigateToDetailViewController(model: Tile) {
        guard let name = model.giveName() else { return }
        switch name {
        case .image:
            guard let url = model.giveData() as? URL else { return }
            let dc = ImageDetailDependencyContainer()
            let vc = dc.makeImageDetailViewController(imageURL: url)
            viewController?.present(vc, animated: true, completion: nil)
        case .video:
            guard let url = model.giveData() as? URL else { return }
            let avPlayerViewController = AVPlayerViewController()
            avPlayerViewController.player = AVPlayer(url: url)
            avPlayerViewController.player?.playImmediately(atRate: 1.0)
            avPlayerViewController.delegate = self
            viewController?.present(avPlayerViewController, animated: true, completion: nil)
        case .website:
            guard let url = model.giveData() as? URL else { return }
            let dc = WebViewDependencyContainer()
            let vc = dc.makeWebViewViewController(pageTitle: model.headline ?? "",
                                                  url: url)
            viewController?.present(vc, animated: true, completion: nil)
        case .shoppingList:
            guard let tileId = model.id else { return }
            let dc = ShopListDependencyContainer()
            let vc = dc.makeShopListViewController(tileId: tileId)
            viewController?.present(vc, animated: true, completion: nil)
        }
    }
}

extension HomeRouter: AVPlayerViewControllerDelegate {
    
}
