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
}

extension MemberAPI: APITarget {
    var endPoint: String {
        switch self {
        case .signUp:
            "/member"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .signUp:
            .post
        }
    }
    
    var task: Task {
        switch self {
        case .signUp:
            .jsonEncoding
        }
    }
    
    var parameters: Parameters {
        switch self {
        case let .signUp(socialType, socialId):
            [
                "socialType": socialType,
                "socialId": socialId
            ]
        }
    }
}
