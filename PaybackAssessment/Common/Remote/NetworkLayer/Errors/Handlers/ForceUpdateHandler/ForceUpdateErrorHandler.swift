//
//  ForceUpdateErrorHandler.swift
//  MockFlash
//
//  Created by mohammad on 5/18/21.
//

import Foundation

class ForceUpdateErrorHandler: ErrorHandlerProtocol {
    let error: GeneralErrors
    
    init(error: GeneralErrors) {
        self.error = error
    }
    
    func handleError() {
        guard case GeneralErrors.forceUpdate(messages: _) = error else { return }
//        AppDelegate.getInstance().callEventManager.forceUpdateErrorOccured()
//        WindowManager.shared.changeRootToForceUpdateViewController()
    }
}
