//
//  ChatFlowCoordinator.swift
//  innergrim
//
//  Created by 지연 on 11/23/24.
//

import UIKit

import Feature
import Shared

protocol ChatFlowCoordinatorDelegate: AnyObject {
    func chatFlowDidFinish(_ coordinator: ChatFlowCoordinator)
}

final class ChatFlowCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    weak var delegate: ChatFlowCoordinatorDelegate?
    
    private let navigationController: UINavigationController
    private let chatDIContainer: ChatDIContainer
    
    init(
        navigationController: UINavigationController,
        chatDIContainer: ChatDIContainer
    ) {
        self.navigationController = navigationController
        self.chatDIContainer = chatDIContainer
    }
    
    func start() {
        showChatViewController()
    }
    
    private func showChatViewController() {
        let viewController = chatDIContainer.makeChatViewController()
        viewController.delegate = self
        navigationController.pushViewController(viewController, animated: false)
    }
}

extension ChatFlowCoordinator: ChatViewControllerDelegate {
    func chatViewControllerDidFinish() {
        navigationController.popViewController(animated: false)
        delegate?.chatFlowDidFinish(self)
    }
}
