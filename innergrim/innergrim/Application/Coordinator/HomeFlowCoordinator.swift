//
//  HomeFlowCoordinator.swift
//  innergrim
//
//  Created by 지연 on 12/19/24.
//

import UIKit

final class HomeFlowCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    
    private let navigationController: UINavigationController
    private let homeDIContainer: HomeDIContainer
    
    init(
        navigationController: UINavigationController,
        homeDIContainer: HomeDIContainer
    ) {
        self.navigationController = navigationController
        self.homeDIContainer = homeDIContainer
    }
    
    func start() {
        showHomeViewController()
    }
    
    private func showHomeViewController() {
        let viewController = homeDIContainer.makeHomeViewController()
        viewController.delegate = self
        navigationController.pushViewController(viewController, animated: false)
    }
    
    private func showChatViewController() {
        let viewController = homeDIContainer.makeChatViewController()
        viewController.modalPresentationStyle = .overFullScreen
        navigationController.present(viewController, animated: true)
    }
}

extension HomeFlowCoordinator: HomeViewControllerDelegate {
    func chatViewControllerWillAppear() {
        showChatViewController()
    }
}
