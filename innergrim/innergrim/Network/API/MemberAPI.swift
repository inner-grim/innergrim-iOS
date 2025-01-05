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
    case checkNicknameDuplicated(nickname: String)
    case withdraw
}

extension MemberAPI: APITarget {
    var endPoint: String {
        switch self {
        case .signUp, .withdraw:
            "/member"
        case .onboarding:
            "/member/on-boarding"
        case .checkNicknameDuplicated:
            "/member/duplicate/nickname"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .signUp, .onboarding:
            .post
        case .checkNicknameDuplicated:
            .get
        case .withdraw:
            .delete
        }
    }
    
    var task: Task {
        switch self {
        case .signUp, .onboarding:
            .jsonEncoding
        case .checkNicknameDuplicated:
            .urlEncoding
        case .withdraw:
            .plain
        }
    }
    
    var parameters: Parameters {
        switch self {
        case let .signUp(socialType, socialId):
            [
                "socialType": socialType,
                "loginId": socialId
            ]
        case let .onboarding(nickname), let .checkNicknameDuplicated(nickname):
            [
                "nickname": nickname
            ]
        case .withdraw:
            [:]
        }
    }
}
