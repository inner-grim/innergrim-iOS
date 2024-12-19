//
//  HomeDIContainer.swift
//  innergrim
//
//  Created by 지연 on 12/19/24.
//

import UIKit

final class HomeDIContainer {
    // MARK: - View Models
    
    private func makeChatViewModel() -> ChatViewModel {
        return ChatViewModel()
    }

    // MARK: - View Controllers
    
    func makeHomeViewController() -> HomeViewController {
        let viewController = HomeViewController()
        return viewController
    }
    
    func makeChatViewController() -> ChatViewController {
        let viewModel = makeChatViewModel()
        let viewController = ChatViewController(viewModel: viewModel)
        return viewController
    }
}
