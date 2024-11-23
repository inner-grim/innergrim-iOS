//
//  HomeFlowCoordinator.swift
//  innergrim
//
//  Created by 지연 on 11/23/24.
//

import UIKit

import Shared

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
        navigationController.pushViewController(viewController, animated: true)
    }
}
