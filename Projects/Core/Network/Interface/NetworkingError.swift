//
//  NetworkingError.swift
//  CoreNetwork
//
//  Created by 지연 on 9/24/24.
//

import Foundation

public enum NetworkingError: Error {
    case invalidRequest
    case invalidResponse
    case decodingError
    case unauthorized
    case clientError(statusCode: Int)
    case serverError(statusCode: Int)
    case unknown(Error)
}
