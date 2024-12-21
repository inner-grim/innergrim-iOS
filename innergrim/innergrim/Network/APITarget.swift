//
//  APITarget.swift
//  innergrim
//
//  Created by 지연 on 12/19/24.
//

import Alamofire
import Foundation

enum Task {
    case plain
    case urlEncoding
    case jsonEncoding
}

protocol APITarget: URLRequestConvertible {
    var baseURL: URL { get }
    var endPoint: String { get }
    var method: HTTPMethod { get }
    var task: Task { get }
    var parameters: Parameters { get }
    
    func asURLRequest() throws -> URLRequest
}

extension APITarget {
    var baseURL: URL {
        if let urlString = Bundle.main.object(forInfoDictionaryKey: "INGM_URL") as? String,
           let decodedUrlString = urlString.removingPercentEncoding,
           let url = URL(string: decodedUrlString) {
            return url
        } else {
            fatalError("INGM_URL 생성 실패")
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = baseURL.appendingPathComponent(endPoint)
        var request = URLRequest(url: url)
        request.method = method
        
        switch task {
        case .urlEncoding:
            return try URLEncoding.default.encode(request, with: parameters)
        case .jsonEncoding:
            return try JSONEncoding.default.encode(request, with: parameters)
        default:
            return request
        }
    }
}
