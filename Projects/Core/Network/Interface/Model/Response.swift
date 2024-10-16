//
//  Response.swift
//  CoreNetworkInterface
//
//  Created by 지연 on 10/17/24.
//

import Foundation

public struct Response<T: Codable>: Codable {
    public let statusCode: String
    public let message: String
    public let data: T
}
