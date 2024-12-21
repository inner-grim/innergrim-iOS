//
//  AuthAPI.swift
//  innergrim
//
//  Created by 지연 on 12/19/24.
//

import Alamofire
import Foundation

enum AuthAPI {
    case login(socialType: String, socialId: String)
}

extension AuthAPI: APITarget {
    var endPoint: String {
        switch self {
        case .login:
            "/auth/member/login"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .login:
            .post
        }
    }
    
    var task: Task {
        switch self {
        case .login:
            .jsonEncoding
        }
    }
    
    var parameters: Parameters {
        switch self {
        case let .login(socialType, socialId):
            [
                "socialType": socialType,
                "socialId": socialId
            ]
        }
    }
}
