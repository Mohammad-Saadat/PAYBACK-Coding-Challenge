//
//  ShopListItemViewModel.swift
//  PaybackAssessment
//
//  Created by mohammadSaadat on 3/14/1400 AP.
//

import Foundation

class ShopListItemViewModel: DefaultCellViewModel {
    init(item: String) {
        super.init(nibName: "ShopListTableViewCell", reuseId: "ShopListTableViewCell", model: item)
    }
}
