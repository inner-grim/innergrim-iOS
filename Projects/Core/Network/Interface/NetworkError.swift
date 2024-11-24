//
//  NetworkError.swift
//  Network
//
//  Created by 지연 on 11/24/24.
//

import Foundation

public enum NetworkError: Error {
    case invalidRequest
    case invalidResponse
    case decodingError
    case unauthorized
    case clientError(statusCode: Int)
    case serverError(statusCode: Int)
    case unknown(Error)
}
