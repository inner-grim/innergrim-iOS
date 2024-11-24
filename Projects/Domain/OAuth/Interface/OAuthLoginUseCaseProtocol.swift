//
//  OAuthLoginUseCaseProtocol.swift
//  OAuth
//
//  Created by 지연 on 11/24/24.
//
import Combine

public protocol OAuthLoginUseCaseProtocol {
    func login(with provider: OAuthProvider) -> AnyPublisher<OAuthResult, OAuthError>
}
