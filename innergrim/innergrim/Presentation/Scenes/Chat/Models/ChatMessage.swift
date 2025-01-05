//
//  ChatMessage.swift
//  innergrim
//
//  Created by 지연 on 12/19/24.
//

import Foundation

enum ChatMessageState: Codable {
    case user
    case assistant
    case loading
    case end
    case networkError
}

struct ChatMessage: Hashable, Codable {
    var id = UUID()
    let content: String
    var timestamp: Date = .init()
    let state: ChatMessageState
    
    func toEntity() -> ChatEntity {
        return ChatEntity(
            role: state == .user ? "user" : "assistant",
            content: content
        )
    }
}
