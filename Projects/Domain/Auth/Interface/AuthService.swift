//
//  AuthService.swift
//  DomainAuthInterface
//
//  Created by 지연 on 10/15/24.
//

import Combine

public protocol AuthService {
    var provider: AuthProvider { get }
    func login() -> AnyPublisher<UserEntity, AuthError>
}
