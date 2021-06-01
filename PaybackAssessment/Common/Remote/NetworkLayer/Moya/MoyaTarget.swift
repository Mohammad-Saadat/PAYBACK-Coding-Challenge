//
//  MoyaTarget.swift
//  MockFlash
//
//  Created by mohammad on 5/18/21.
//

import Foundation
import Moya
import Alamofire

class MoyaTarget: TargetType, AccessTokenAuthorizable {
    var authorizationType: AuthorizationType?
    var path: String
    var method: Moya.Method = .get
    var sampleData: Data
    var task: Task = .requestPlain
    var headers: [String: String]?
    var baseURL: URL
    
    init(mockFlashRequest: RequestProtocol) {
        self.baseURL = mockFlashRequest.baseURL
        self.path = mockFlashRequest.relativePath
        self.sampleData = Data()
        self.headers = mockFlashRequest.headers
        self.setTask(type: mockFlashRequest.requestType)
        self.setMoyaMethod(method: mockFlashRequest.method)
        self.setAuthorizationType(type: mockFlashRequest.authorizationType)
    }
    
    private func setAuthorizationType(type: AuthType) {
        switch type {
        case .none:
            self.authorizationType = nil
        case .basic:
            self.authorizationType = .basic
        case .bearer:
            self.authorizationType = .bearer
        case .custom(let param):
            self.authorizationType = .custom(param)
        }
    }
    
    private func setTask(type: RequestType) {
        switch type {
        case .requestPlain:
            self.task = .requestPlain
        case .requestJSONEncodable(let encodable, let encoder):
            self.task = .requestCustomJSONEncodable(encodable, encoder: encoder)
        case .requestParameters(let urlParameters, let encoding):
            switch encoding {
            case .queryString:
                self.task = .requestParameters(parameters: urlParameters, encoding: URLEncoding.queryString)
            case .customEncoder:
                self.task = .requestParameters(parameters: urlParameters, encoding: CustomUrlEncoding())
            default:
                break
            }
        case .uploadCompositeMultipart(let formData, let urlParameters):
            let moyaFormData: [Moya.MultipartFormData] = formData.map { MultipartFormData.init(provider: getMoyaFileProvider($0.provider), name: $0.name, fileName: $0.fileName, mimeType: $0.mimeType)}
            if let urlParameter = urlParameters {
                self.task = .uploadCompositeMultipart(moyaFormData, urlParameters: urlParameter)
            } else {
                self.task = .uploadMultipart(moyaFormData)
            }
        }
    }
    
    private func getMoyaFileProvider(_ provider: FormData.FormDataProvider) -> Moya.MultipartFormData.FormDataProvider {
        switch provider {
            
        case .data(let param):
            return .data(param)
        case .file(let param):
            return .file(param)
        case .stream(let param1, let param2):
            return .stream(param1, param2)
        }
    }
    
    private func setMoyaMethod(method: HTTPMethod) {
        switch method {
        case .options:
            self.method = .options
        case .get:
            self.method = .get
        case .head:
            self.method = .head
        case .post:
            self.method = .post
        case .put:
            self.method = .put
        case .patch:
            self.method = .patch
        case .delete:
            self.method = .delete
        case .trace:
            self.method = .trace
        case .connect:
            self.method = .connect
        }
    }
}
