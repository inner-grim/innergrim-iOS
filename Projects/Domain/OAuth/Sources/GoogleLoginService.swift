//
//  GoogleLoginService.swift
//  DomainAuth
//
//  Created by 지연 on 10/15/24.
//

import Combine
import Foundation

import DomainOAuthInterface

public final class GoogleLoginService: OAuthLoginService {
    public let provider: OAuthProvider = .google
    
    public init() {}
    
    public func login() -> AnyPublisher<UserEntity, OAuthError> {
        return Future { promise in
            // 실제 Google 로그인 로직 구현
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                promise(.success(
                    UserEntity(
                        id: "google123",
                        provider: .google
                    )
                ))
            }
        }.eraseToAnyPublisher()
    }
}
