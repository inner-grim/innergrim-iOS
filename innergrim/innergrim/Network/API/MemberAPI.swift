//
//  MemberAPI.swift
//  innergrim
//
//  Created by 지연 on 12/21/24.
//

import Alamofire
import Foundation

enum MemberAPI {
    case signUp(socialType: String, socialId: String)
    case onboarding(nickname: String)
}

extension MemberAPI: APITarget {
    var endPoint: String {
        switch self {
        case .signUp:
            "/member"
        case .onboarding:
            "/member/on-boarding"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .signUp, .onboarding:
            .post
        }
    }
    
    var task: Task {
        switch self {
        case .signUp, .onboarding:
            .jsonEncoding
        }
    }
    
    var parameters: Parameters {
        switch self {
        case let .signUp(socialType, socialId):
            [
                "socialType": socialType,
                "loginId": socialId
            ]
        case let .onboarding(nickname):
            [
                "nickName": nickname
            ]
        }
    }
}
