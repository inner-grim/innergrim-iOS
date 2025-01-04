//
//  OnboardingFlowCoordinator.swift
//  innergrim
//
//  Created by 지연 on 12/19/24.
//

import UIKit

protocol OnboardingFlowCoordinatorDelegate: AnyObject {
    func onboardingFlowDidFinish(_ coordinator: OnboardingFlowCoordinator)
}

final class OnboardingFlowCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    weak var delegate: OnboardingFlowCoordinatorDelegate?
    
    private let navigationController: UINavigationController
    private let onboardingDIContainer: OnboardingDIContainer
    
    // MARK: - Init
    
    init(
        navigationController: UINavigationController,
        onboardingDIContainer: OnboardingDIContainer
    ) {
        self.navigationController = navigationController
        self.onboardingDIContainer = onboardingDIContainer
    }
    
    func start() {
        showLoginViewController()
    }
    
    // MARK: - Private Methods
    
    private func showLoginViewController() {
        let viewController = onboardingDIContainer.makeLoginViewController()
        viewController.delegate = self
        navigationController.pushViewController(viewController, animated: false)
    }
    
    private func showNicknameViewController() {
        let viewController = onboardingDIContainer.makeNicknameViewController()
        viewController.delegate = self
        navigationController.pushViewController(viewController, animated: false)
    }
}

extension OnboardingFlowCoordinator: LoginViewControllerDelegate {
    func loginViewControllerDidFinish() {
        showNicknameViewController()
//        if UserDataStorage.isOnboardingCompleted {
//            delegate?.onboardingFlowDidFinish(self)
//        } else {
//            showNicknameViewController()
//        }
    }
}

extension OnboardingFlowCoordinator: NicknameViewControllerDelegate {
    func nicknameViewControllerDidFinish() {
        delegate?.onboardingFlowDidFinish(self)
    }
}
