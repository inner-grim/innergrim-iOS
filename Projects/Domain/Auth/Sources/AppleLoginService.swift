//
//  AppleLoginService.swift
//  DomainAuth
//
//  Created by 지연 on 10/15/24.
//

import Combine
import Foundation

import DomainAuthInterface

public final class AppleLoginService: AuthService {
    public let provider: AuthProvider = .apple
    
    public init() {}
    
    public func login() -> AnyPublisher<UserEntity, AuthError> {
        return Future { promise in
            // 실제 Apple 로그인 로직 구현
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                promise(.success(
                    UserEntity(
                        id: "apple123",
                        name: "Apple User",
                        provider: .apple
                    )
                ))
            }
        }.eraseToAnyPublisher()
    }
}
