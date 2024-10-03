//
//  RequestBuilder.swift
//  CoreNetwork
//
//  Created by 지연 on 9/24/24.
//

import Foundation

import CoreNetworkInterface

struct RequestBuilder {
    static func buildURLRequest(from target: TargetType) -> URLRequest? {
        var components = URLComponents(
            url: target.baseURL.appendingPathComponent(target.path),
            resolvingAgainstBaseURL: true
        )
        
        if case let .requestParameters(parameters, encoding) = target.task {
            switch encoding {
            case .urlEncoding:
                components?.queryItems = parameters.map {
                    URLQueryItem(name: $0.key, value: "\($0.value)")
                }
            case .jsonEncoding:
                break
            }
        }
        
        guard let url = components?.url else { return nil }
        
        var request = URLRequest(url: url)
        request.httpMethod = target.method.rawValue
        request.allHTTPHeaderFields = target.headers
        
        if case let .requestParameters(parameters, encoding) = target.task, encoding == .jsonEncoding {
            request.httpBody = try? JSONSerialization.data(withJSONObject: parameters)
        }
        
        return request
    }
}
