//
//  UnAuthorizedErrorHandler.swift
//  MockFlash
//
//  Created by mohammad on 5/18/21.
//

import Foundation

class UnAuthorizedErrorHandler: ErrorHandlerProtocol {
    let error: GeneralErrors
    
    init(error: GeneralErrors) {
        self.error = error
    }
    
    func handleError() {
        guard case GeneralErrors.unAuthorized(messages: _) = error else { return }
        removeLocalCredentials()
        WindowManager.shared.changeRootToSplash()
    }
    
    func removeLocalCredentials() {
        self.resetUserDefaults()
    }
    
    func resetUserDefaults() {}

}
