//
//  ChatDIContainer.swift
//  innergrim
//
//  Created by 지연 on 11/23/24.
//

import UIKit

import Feature

final class ChatDIContainer {
    struct Dependencies {}

    private let dependencies: Dependencies

    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    // MARK: - View Models

    // MARK: - View Controllers
    
    func makeChatViewController() -> ChatViewController {
        return ChatViewController()
    }
}
