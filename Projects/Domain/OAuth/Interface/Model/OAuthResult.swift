//
//  OAuthResult.swift
//  DomainOAuthInterface
//
//  Created by 지연 on 10/17/24.
//

import Foundation

public enum OAuthResult {
    case success(OAuthProvider)
    case failure(OAuthError)
}
