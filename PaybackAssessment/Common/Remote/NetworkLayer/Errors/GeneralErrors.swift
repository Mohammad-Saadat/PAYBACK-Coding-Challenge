//
//  GeneralErrors.swift
//  MockFlash
//
//  Created by mohammad on 5/18/21.
//

import Foundation
import Moya

enum GeneralErrors: Error, LocalizedError {
    case unAuthorized(messages: String?)
    case forceUpdate(messages: String?)
    
    var errorDescription: String? {
        switch self {
        case .unAuthorized(let messages):
            return messages ?? "Unauthorized"
        case .forceUpdate(let messages):
            return messages ?? "This app version is no longer supported."
        }
    }
    
    func getHandler() -> ErrorHandlerProtocol {
        switch self {
        case .unAuthorized:
            return UnAuthorizedErrorHandler(error: self)
        case .forceUpdate:
            return ForceUpdateErrorHandler(error: self)
        }
    }
}

extension GeneralErrors {
    static func parseError(_ error: Error) -> GeneralErrors? {        
        guard let moyaError = error as? MoyaError else { return nil }
        
        func parseErrorMessages(_ errorData: Data) -> String? {
            return errorData.utf8String
        }
        
        if case .underlying(_, let moyaResponse) = moyaError ,
            let response = moyaResponse {
            switch moyaResponse?.statusCode {
            case 401?:
                return GeneralErrors.unAuthorized(messages: parseErrorMessages(response.data))
            case 426?:
                return GeneralErrors.forceUpdate(messages: parseErrorMessages(response.data))
            default:
                return nil
            }
        }
        return nil
    }
}
