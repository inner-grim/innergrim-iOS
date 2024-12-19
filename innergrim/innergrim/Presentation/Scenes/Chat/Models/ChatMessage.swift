//
//  ChatMessage.swift
//  innergrim
//
//  Created by 지연 on 12/19/24.
//

import Foundation

struct ChatMessage: Hashable {
    let id = UUID()
    let content: String
    let timestamp: Date = .init()
    let isFromUser: Bool
}
