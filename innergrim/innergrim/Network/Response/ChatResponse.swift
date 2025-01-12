//
//  ChatResponse.swift
//  innergrim
//
//  Created by 지연 on 12/22/24.
//

import Foundation

struct ChatResponse: Decodable {
    let statusCode: String
    let message: String
    let data: Answer?
}

struct Answer: Decodable {
    let answer: String
}
