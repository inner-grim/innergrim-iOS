//
//  ChatBotAPI.swift
//  innergrim
//
//  Created by 지연 on 12/22/24.
//

import Alamofire
import Foundation

enum ChatBotAPI {
    case sendChat(previousConversionList: String, question: String)
}

extension ChatBotAPI: APITarget {
    var endPoint: String {
        switch self {
        case .sendChat:
            "/chat-bot/send/chat"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .sendChat:
            .post
        }
    }
    
    var task: Task {
        switch self {
        case .sendChat:
            .jsonEncoding
        }
    }
    
    var parameters: Parameters {
        switch self {
        case let .sendChat(previousConversionList, question): [
            "previousConversionList": previousConversionList,
            "question": question
        ]
        }
    }
}
