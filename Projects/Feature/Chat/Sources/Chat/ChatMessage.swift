//
//  ChatMessage.swift
//  Chat
//
//  Created by 지연 on 11/23/24.
//

import Foundation

public struct ChatMessage {
    let content: String
    let timestamp: Date
    let isFromUser: Bool
    
    init(content: String, timestamp: Date = .init(), isFromUser: Bool) {
        self.content = content
        self.timestamp = timestamp
        self.isFromUser = isFromUser
    }
}
