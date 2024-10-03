//
//  TestAPI.swift
//  CoreNetwork
//
//  Created by 지연 on 9/24/24.
//

import Foundation

public enum TestAPI {
    case getUser(username: String)
}

extension TestAPI: TargetType {
    public var baseURL: URL {
        URL(string: "https://api.github.com")!
    }
    
    public var path: String {
        switch self {
        case .getUser(let username): "/users/\(username)"
        }
    }
    
    public var method: HTTPMethod {
        switch self {
        case .getUser: .get
        }
    }
    
    public var task: HTTPTask {
        switch self {
        case .getUser: .requestPlain
        }
    }
    
    public var headers: [String : String]? {
        ["Content-Type": "application/json"]
    }
}
