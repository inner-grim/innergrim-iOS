//
//  IncomingMessage.swift
//  FeatureHome
//
//  Created by 지연 on 11/6/24.
//

import Foundation

public struct IncomingMessage {
    let message: String
    let date: Date
    
    init(message: String, date: Date = .init()) {
        self.message = message
        self.date = date
    }
}
