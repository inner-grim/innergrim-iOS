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
    public let provider: AuthProvider

    public init(id: String, name: String, provider: AuthProvider) {
        self.id = id
        self.name = name
        self.provider = provider
    }
}
