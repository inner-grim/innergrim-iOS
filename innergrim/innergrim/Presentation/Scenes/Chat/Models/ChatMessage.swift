//
//  ChatMessage.swift
//  innergrim
//
//  Created by 지연 on 12/19/24.
//

import Foundation

struct ChatMessage: Hashable, Codable {
    var id = UUID()
    let content: String
    var timestamp: Date = .init()
    let isFromUser: Bool
}
