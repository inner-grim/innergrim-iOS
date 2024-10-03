//
//  NetworkingService.swift
//  CoreNetwork
//
//  Created by 지연 on 9/24/24.
//

import Combine
import Foundation

import CoreNetworkInterface

public class NetworkingService: NetworkingProtocol {
    private let session: URLSession
    
    public init(session: URLSession = .shared) {
        self.session = session
    }
    
    public func request<T: Decodable>(
        _ target: TargetType,
        responseType: T.Type
    ) -> AnyPublisher<T, NetworkingError> {
        guard let request = RequestBuilder.buildURLRequest(from: target) else {
            return Fail(error: NetworkingError.invalidRequest).eraseToAnyPublisher()
        }
        
        return session.dataTaskPublisher(for: request)
            .tryMap { data, response -> Data in
                guard let httpResponse = response as? HTTPURLResponse else {
                    throw NetworkingError.invalidResponse
                }
                switch httpResponse.statusCode {
                case 200...299:
                    return data
                case 401:
                    throw NetworkingError.unauthorized
                case 400...499:
                    throw NetworkingError.clientError(statusCode: httpResponse.statusCode)
                case 500...599:
                    throw NetworkingError.serverError(statusCode: httpResponse.statusCode)
                default:
                    throw NetworkingError.unknown(NSError(domain: "HTTPError", code: httpResponse.statusCode, userInfo: nil))
                }
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .mapError { error in
                if let networkingError = error as? NetworkingError {
                    return networkingError
                } else if error is DecodingError {
                    return NetworkingError.decodingError
                } else {
                    return NetworkingError.unknown(error)
                }
            }
            .eraseToAnyPublisher()
    }
}
