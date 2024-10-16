//
//  OAuthError.swift
//  DomainAuthInterface
//
//  Created by 지연 on 10/15/24.
//

import Foundation

public enum OAuthError: Error {
    case unsupportedProvider
    case unknown
    case invalidResponse
    case clientError
    case serverError
    case authenticationFailed
}
