//
//  OAuthLoginUseCase.swift
//  DomainAuthInterface
//
//  Created by 지연 on 10/15/24.
//

import Combine

public protocol OAuthLoginUseCase {
    func login(with provider: OAuthProvider) -> AnyPublisher<UserEntity, OAuthError>
}
