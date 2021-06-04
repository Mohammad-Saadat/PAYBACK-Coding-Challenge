//
//  HomeWorker.swift
//  PaybackAssessment
//
//  Created by mohammad on 6/2/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import PromiseKit

protocol HomeWorkerLogic {
    func getTails(params: TailParams) -> Promise<[Tile]>
    func refreshTails(params: TailParams) -> Promise<[Tile]>
}

class HomeWorker {
    // MARK: - Object lifecycle
    init(service: HomeService) {
        HomeLogger.logInit(owner: String(describing: HomeWorker.self))
        self.service = service
    }
    
    // MARK: - Deinit
    deinit {
        HomeLogger.logDeinit(owner: String(describing: HomeWorker.self))
    }
    
    // MARK: - Properties
    
    // MARK: Private
    private let service: HomeService
}

// MARK: - Methods

// MARK: Private
private extension HomeWorker {}

// MARK: - Worker Logic
extension HomeWorker: HomeWorkerLogic {
    func getTails(params: TailParams) -> Promise<[Tile]> {
        service.getTails(params: params)
    }
    
    func refreshTails(params: TailParams) -> Promise<[Tile]> {
        service.refreshTails(params: params)
    }
}
