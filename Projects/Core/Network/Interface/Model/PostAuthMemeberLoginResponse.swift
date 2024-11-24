//
//  PostAuthMemeberLoginResponse.swift
//  Network
//
//  Created by 지연 on 11/24/24.
//

import Foundation

public struct PostAuthMemeberLoginResponseData: Codable {
    public let accessToken: String
    public let refreshToken: String
}

public struct PostAuthMemeberLoginResponse: Codable {
    public let statusCode: String
    public let message: String
    public let data: PostAuthMemeberLoginResponseData?
}
