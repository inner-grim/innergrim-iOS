//
//  AuthUseCaseImpl.swift
//  DomainAuth
//
//  Created by 지연 on 10/15/24.
//

import Combine
import Foundation

import DomainAuthInterface

public final class AuthUseCaseImpl: AuthUseCase {
    private let authServices: [AuthService]
    
    init(authServices: [AuthService]) {
        self.authServices = authServices
    }
    
    public func login(with provider: AuthProvider) -> AnyPublisher<UserEntity, AuthError> {
        guard let service = authServices.first(where: { $0.provider == provider }) else {
            return Fail(error: .unsupportedProvider).eraseToAnyPublisher()
        }
        return service.login()
    }
}
