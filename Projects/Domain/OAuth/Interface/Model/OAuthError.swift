//
//  OAuthError.swift
//  DomainAuthInterface
//
//  Created by 지연 on 10/15/24.
//

import AuthenticationServices
import Foundation

import Core
import KakaoSDKCommon

public enum OAuthError: Error {
    case unsupportedProvider
    case invalidResponse
    case unauthorized
    case clientError
    case serverError
    case kakaoError(SdkError)
    case appleError(ASAuthorizationError)
    case networkError(NetworkError)
    case unknown(Error)
}
