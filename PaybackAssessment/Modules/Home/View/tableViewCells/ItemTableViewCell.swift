//
//  ItemTableViewCell.swift
//  PaybackAssessment
//
//  Created by mohammad on 6/2/21.
//

import UIKit

class ItemTableViewCell: UITableViewCell {
    
    // ===============
    // MARK: - Outlets
    // ===============
    @IBOutlet weak var headLineLabel: UILabel!
    @IBOutlet weak var sublineLabel: UILabel!
    @IBOutlet weak var patchImageView: UIImageView! {
        didSet {
            patchImageView.addCornerRadius(12)
        }
    }
    
}

extension ItemTableViewCell: Binder {
    func bind(_ viewModel: Any) {
        if let viewModel = viewModel as? ItemCellViewModel,
            let model = viewModel.getModel() as? Tile {
            setup(with: model)
        }
    }
}

private extension ItemTableViewCell {
    func setup(with model: Tile) {
        headLineLabel.text = model.headline
        sublineLabel.text = model.subline
//        if let launchDate = model.dateLocal?.toDate(withFormat: "yyyy-MM-dd'T'HH:mm:ssZ").toString(withFormat: "yyyy-MM-dd") {
//            launchDateLabel.text = "launch date: \(launchDate)"
//        }
//        setPathcImage(with: model.links?.patch?.small)
    }
}

