//
//  AuthUseCaseImpl.swift
//  DomainAuth
//
//  Created by 지연 on 10/15/24.
//

import Combine
import Foundation

import DomainOAuthInterface

public final class OAuthUseCaseImpl: OAuthLoginUseCase {
    private let loginServices: [OAuthLoginService]
    
    public init(loginServices: [OAuthLoginService]) {
        self.loginServices = loginServices
    }
    
    public func login(with provider: OAuthProvider) -> AnyPublisher<UserEntity, OAuthError> {
        guard let service = loginServices.first(where: { $0.provider == provider }) else {
            return Fail(error: .unsupportedProvider).eraseToAnyPublisher()
        }
        return service.login()
    }
}
