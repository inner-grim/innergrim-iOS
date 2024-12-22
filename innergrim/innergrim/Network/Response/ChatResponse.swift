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
    private let answer: String

    // 중첩된 JSON 문자열을 파싱
    var parsedResponse: String? {
        guard let jsonData = answer.data(using: .utf8) else { return nil }
        do {
            let responseObject = try JSONDecoder().decode(NestedResponse.self, from: jsonData)
            return responseObject.response
        } catch {
            print("Failed to decode nested response: \(error)")
            return nil
        }
    }
}

struct NestedResponse: Decodable {
    let response: String
}
