//
//  ShopListModels.swift
//  PaybackAssessment
//
//  Created by mohammadSaadat on 3/14/1400 AP.
//  Copyright (c) 1400 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

enum ShopList {
    // MARK: Use cases
    
    enum Add {
        struct Request {
            var item: String
        }
        struct Response {
            var items: [String]
        }
        struct ViewModel {
            var sections: [SectionViewModel]
        }
    }
    
    enum ErrorModel {
        struct Response {
            var error: Error
        }
        struct ViewModel {
            var error: Error
        }
    }
}
