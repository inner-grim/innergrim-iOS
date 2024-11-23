//
//  HomeFlowCoordinator.swift
//  innergrim
//
//  Created by 지연 on 11/23/24.
//

import UIKit

import Feature
import Shared

protocol HomeFlowCoordinatorDelegate: AnyObject {
    func homeFlowCoordinatorDidRequestChatFlow()
}

final class HomeFlowCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    weak var delegate: HomeFlowCoordinatorDelegate?
    
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
}

extension HomeFlowCoordinator: HomeViewControllerDelegate {
    func homeViewControllerDidRequestChat() {
        delegate?.homeFlowCoordinatorDidRequestChatFlow()
    }
}
