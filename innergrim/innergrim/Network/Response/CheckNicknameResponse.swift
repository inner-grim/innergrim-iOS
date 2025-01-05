//
//  CheckNicknameResponse.swift
//  innergrim
//
//  Created by 지연 on 12/22/24.
//

import Foundation

struct CheckNicknameResponse: Decodable {
    let statusCode: String
    let message: String
    let data: Bool?
}
