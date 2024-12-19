//
//  APIService.swift
//  innergrim
//
//  Created by 지연 on 12/19/24.
//

import Combine
import Foundation

import Alamofire

final class APIService {
    private init() {}
    
    static func request<T: Decodable>(
        _ target: APITarget,
        responseType: T.Type
    ) -> AnyPublisher<T, AFError> {
        return AF
            .request(target, interceptor: Interceptor())
            .publishDecodable(type: responseType)
            .value()
            .eraseToAnyPublisher()
    }
}
