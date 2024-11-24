//
//  OAuthResult.swift
//  OAuth
//
//  Created by 지연 on 11/24/24.
//

import Foundation

public enum OAuthResult {
    case success((provider: OAuthProvider, id: String))
    case failure(OAuthError)
}
