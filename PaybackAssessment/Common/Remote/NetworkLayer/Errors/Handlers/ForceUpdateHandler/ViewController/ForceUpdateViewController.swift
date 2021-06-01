//
//  ForceUpdateViewController.swift
//  Mercury
//
//  Created by mohammad on 5/18/21.
//

import UIKit

class ForceUpdateViewController: UIViewController {
    @IBOutlet private weak var containerView: UIView! {
        didSet {
            self.containerView.addCornerRadius(15.0)
        }
    }
    @IBOutlet private weak var titleLabel: UILabel! {
        didSet {
            self.titleLabel.text = self.forceUpdateTitle
        }
    }
    @IBOutlet private weak var descriptionLabel: UILabel! {
        didSet {
            self.descriptionLabel.text = self.forceUpdateMessage
        }
    }
    @IBOutlet private weak var okButton: UIButton! {
        didSet {
            self.okButton.addCornerRadius(15.0)
        }
    }
    
    var forceUpdateMessage: String = ""
    var forceUpdateTitle: String = "Error".localized
    var router: ForceUpdateRouter?
    
    init(forceUpdateMessage: String, forceUpdateTitle: String) {
        self.forceUpdateTitle = forceUpdateTitle
        self.forceUpdateMessage = forceUpdateMessage
        self.router = ForceUpdateRouter()
        super.init(nibName: "ForceUpdateViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
        self.router?.viewController = self
    }
}
