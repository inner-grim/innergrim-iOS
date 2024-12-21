//
//  LoginResponse.swift
//  innergrim
//
//  Created by 지연 on 12/20/24.
//

import Foundation

struct LoginResponse: Decodable {
    let statusCode: String
    let message: String
    let data: TokenData?
}

struct TokenData: Decodable {
    let accessToken: String
    let refreshToken: String
}
