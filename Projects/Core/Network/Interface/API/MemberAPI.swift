//
//  MemberAPI.swift
//  CoreNetworkInterface
//
//  Created by 지연 on 10/17/24.
//

import Foundation

public enum MemberAPI {
    case postMember(socialType: String, socialId: String)
}

extension MemberAPI: TargetType {
    public var path: String {
        switch self {
        case .postMember: "/member"
        }
    }
    
    public var method: HTTPMethod {
        switch self {
        case .postMember: .post
        }
    }
    
    public var task: Task {
        switch self {
        case let .postMember(socialType, socialId):
                .requestParameters(
                    parameters: ["socialType": socialType, "socialId": socialId],
                    encoding: .jsonEncoding
                )
        }
    }
}
