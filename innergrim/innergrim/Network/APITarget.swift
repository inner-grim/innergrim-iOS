//
//  APITarget.swift
//  innergrim
//
//  Created by 지연 on 12/19/24.
//

import Alamofire
import Foundation

protocol APITarget: URLRequestConvertible {
    var baseURL: URL { get }
    var endPoint: String { get }
    var method: HTTPMethod { get }
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
}
