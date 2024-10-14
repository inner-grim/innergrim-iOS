//
//  GoogleLoginService.swift
//  DomainAuth
//
//  Created by 지연 on 10/15/24.
//

import Combine
import Foundation

import DomainAuthInterface

public final class GoogleLoginService: AuthService {
    public let provider: AuthProvider = .google
    
    public func login() -> AnyPublisher<UserEntity, AuthError> {
        return Future { promise in
            // 실제 Google 로그인 로직 구현
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                promise(.success(
                    UserEntity(
                        id: "google123",
                        name: "Google User",
                        provider: .google
                    )
                ))
            }
        }.eraseToAnyPublisher()
    }
}
