//
//  AuthAPI.swift
//  Network
//
//  Created by 지연 on 11/24/24.
//

import Foundation

public enum AuthAPI {
    case postAuthMemberLogin(socialType: String, socialId: String)
}

extension AuthAPI: TargetType {
    public var path: String {
        switch self {
        case .postAuthMemberLogin: "/auth/member/login"
        }
    }
    
    public var method: HTTPMethod {
        switch self {
        case .postAuthMemberLogin: .post
        }
    }
    
    public var task: Task {
        switch self {
        case let .postAuthMemberLogin(socialType, socialId):
                .requestParameters(
                    parameters: ["socialType": socialType, "socialId": socialId],
                    encoding: .jsonEncoding
                )
        }
    }
}
