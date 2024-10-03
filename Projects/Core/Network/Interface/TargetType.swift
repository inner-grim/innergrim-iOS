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
    var task: HTTPTask { get }
    var headers: [String: String]? { get }
}