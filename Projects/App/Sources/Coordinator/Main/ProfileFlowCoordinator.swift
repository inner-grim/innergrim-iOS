//
//  ProfileFlowCoordinator.swift
//  innergrim
//
//  Created by 지연 on 11/23/24.
//

import UIKit

import Shared

final class ProfileFlowCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    
    private let navigationController: UINavigationController
    private let profileDIContainer: ProfileDIContainer
    
    init(
        navigationController: UINavigationController,
        profileDIContainer: ProfileDIContainer
    ) {
        self.navigationController = navigationController
        self.profileDIContainer = profileDIContainer
    }
    
    func start() {
        showProfileViewController()
    }
    
    private func showProfileViewController() {
        let viewController = profileDIContainer.makeProfileViewController()
        navigationController.pushViewController(viewController, animated: true)
    }
}
