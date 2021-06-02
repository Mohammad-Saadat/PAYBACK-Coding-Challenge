//
//  HomeModels.swift
//  PaybackAssessment
//
//  Created by mohammad on 6/2/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

enum Home {
    // MARK: Use cases
    
    enum ErrorModel {
        struct Response {
            var error: Error
        }
        struct ViewModel {
            var error: Error
        }
    }
    
    enum Item {
        struct Response {
            var Tiles: [Tile]
        }
        struct ViewModel {
            var sections: [SectionViewModel]
        }
    }
}
