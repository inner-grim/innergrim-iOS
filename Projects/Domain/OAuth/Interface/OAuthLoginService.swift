//
//  OAuthLoginService.swift
//  DomainAuthInterface
//
//  Created by 지연 on 10/15/24.
//

import Combine

public protocol OAuthLoginService {
    var provider: OAuthProvider { get }
    func login() -> AnyPublisher<String, OAuthError>
}
