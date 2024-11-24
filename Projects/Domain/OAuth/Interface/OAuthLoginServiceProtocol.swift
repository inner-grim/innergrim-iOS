//
//  OAuthLoginServiceProtocol.swift
//  OAuth
//
//  Created by 지연 on 11/24/24.
//

import Combine

public protocol OAuthLoginServiceProtocol {
    var provider: OAuthProvider { get }
    func login() -> AnyPublisher<String, OAuthError>
}
