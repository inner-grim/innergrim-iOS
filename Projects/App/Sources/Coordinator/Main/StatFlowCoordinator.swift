//
//  StatFlowCoordinator.swift
//  innergrim
//
//  Created by 지연 on 11/23/24.
//

import UIKit

import Shared

final class StatFlowCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    
    private let navigationController: UINavigationController
    private let statDIContainer: StatDIContainer
    
    init(
        navigationController: UINavigationController,
        statDIContainer: StatDIContainer
    ) {
        self.navigationController = navigationController
        self.statDIContainer = statDIContainer
    }
    
    func start() {
        showStatViewController()
    }
    
    private func showStatViewController() {
        let viewController = statDIContainer.makeStatViewController()
        navigationController.pushViewController(viewController, animated: true)
    }
}
