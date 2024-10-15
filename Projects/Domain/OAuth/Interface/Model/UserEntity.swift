//
//  UserEntity.swift
//  DomainAuthInterface
//
//  Created by 지연 on 10/15/24.
//

import Foundation

public struct UserEntity {
    public let id: String
    public let name: String
    public let email: String?
    public let provider: OAuthProvider

    public init(id: String, name: String, email: String?, provider: OAuthProvider) {
        self.id = id
        self.name = name
        self.email = email
        self.provider = provider
    }
}
