//
//  ItemCellViewModel.swift
//  PaybackAssessment
//
//  Created by mohammad on 6/2/21.
//

import Foundation

class ItemCellViewModel: DefaultCellViewModel {
    init(tile: Tile) {
        super.init(nibName: "ItemTableViewCell", reuseId: "ItemTableViewCell", model: tile)
    }
}
