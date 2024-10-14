//
//  AuthUseCase.swift
//  DomainAuthInterface
//
//  Created by 지연 on 10/15/24.
//

import Combine

public protocol AuthUseCase {
    func login(with provider: AuthProvider) -> AnyPublisher<UserEntity, AuthError>
}
