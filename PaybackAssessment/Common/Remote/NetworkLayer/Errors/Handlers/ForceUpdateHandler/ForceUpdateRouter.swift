//
//  ForceUpdateRouter.swift
//  TRB
//
//  Created by mohammad on 5/18/21.
//

import UIKit

protocol ForceUpdateRoutingLogic {
    func navigateToForceUpdateAlert()
}

protocol ForceUpdateDataPassing {}

class ForceUpdateRouter: NSObject, ForceUpdateDataPassing {
    // MARK: - Object lifecycle
    override init() {}
    
    // MARK: - Deinit
    deinit {}
    
    // MARK: - Properties
    
    // MARK: Public
    weak var viewController: ForceUpdateViewController?
}

// MARK: - Methods

// MARK: Private
private extension ForceUpdateRouter {}

// MARK: Public
extension ForceUpdateRouter {}

// MARK: - Routin Logic
extension ForceUpdateRouter: ForceUpdateRoutingLogic {
    // MARK: Navigation
    func navigateToForceUpdateAlert() {
//        let dc = TRBAlertDependencyContainer(model: model)
//        let vc = dc.makeTRABAlertViewController()
//        vc.modalPresentationStyle = .overFullScreen
//        self.viewController?.present(vc, animated: false, completion: nil)
    }
}
