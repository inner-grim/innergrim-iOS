//
//  NetworkServiceProtocol.swift
//  Network
//
//  Created by 지연 on 11/24/24.
//

import Combine
import Foundation

public protocol NetworkServiceProtocol {
    func request<T: Decodable>(
        _ target: TargetType,
        responseType: T.Type
    ) -> AnyPublisher<T, NetworkError>
}
