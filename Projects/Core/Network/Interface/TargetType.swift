//
//  TargetType.swift
//  CoreNetwork
//
//  Created by 지연 on 9/24/24.
//

import Foundation

// API 정의를 위한 프로토콜
public protocol TargetType {
    var baseURL: URL { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var task: Task { get }
    var headers: [String: String]? { get }
}

extension TargetType {
    public var baseURL: URL {
        if let urlString = Bundle.main.object(forInfoDictionaryKey: "INGM_URL") as? String,
           let decodedUrlString = urlString.removingPercentEncoding,
           let url = URL(string: decodedUrlString) {
            return url
        } else {
            fatalError("INGM_URL 생성 실패")
        }
    }
    
    public var headers: [String : String]? {
        ["Content-Type": "application/json"]
    }
}
