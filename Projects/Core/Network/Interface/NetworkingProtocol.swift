//
//  NetworkingProtocol.swift
//  CoreNetwork
//
//  Created by 지연 on 9/24/24.
//

import Combine
import Foundation

public protocol NetworkingProtocol {
    func request<T: Decodable>(
        _ target: TargetType,
        responseType: T.Type
    ) -> AnyPublisher<T, NetworkingError>
}
