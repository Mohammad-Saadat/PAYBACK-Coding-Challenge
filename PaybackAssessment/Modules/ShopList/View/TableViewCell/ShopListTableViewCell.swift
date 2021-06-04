//
//  ShopListTableViewCell.swift
//  PaybackAssessment
//
//  Created by mohammadSaadat on 3/14/1400 AP.
//

import UIKit

class ShopListTableViewCell: UITableViewCell {

    // ===============
    // MARK: - Outlets
    // ===============
    @IBOutlet weak var itemLabel: UILabel!
}

extension ShopListTableViewCell: Binder {
    func bind(_ viewModel: Any) {
        if let viewModel = viewModel as? ShopListItemViewModel,
            let model = viewModel.getModel() as? String {
            itemLabel.text = model
        }
    }
}
