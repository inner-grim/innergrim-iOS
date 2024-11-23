//
//  OnboardingFlowCoordinator.swift
//  innergrim
//
//  Created by 지연 on 11/23/24.
//

import UIKit

import Feature
import Shared

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
        showOnboardingViewController()
    }
    
    // MARK: - Private Methods
    
    private func showOnboardingViewController() {
        let viewController = onboardingDIContainer.makeOnboardingViewController()
        viewController.delegate = self
        navigationController.pushViewController(viewController, animated: false)
    }
    
    private func showLoginViewController() {
        let viewController = onboardingDIContainer.makeLoginViewController()
        viewController.delegate = self
        navigationController.pushViewController(viewController, animated: false)
    }
    
    private func showAgreementViewController() {
        let viewController = onboardingDIContainer.makeAgreementViewController()
        viewController.delegate = self
        navigationController.pushViewController(viewController, animated: false)
    }
    
    private func showNicknameViewController() {
        let viewController = onboardingDIContainer.makeNicknameViewController()
//        viewController.delegate = self
        navigationController.pushViewController(viewController, animated: false)
    }
}

extension OnboardingFlowCoordinator: OnboardingViewControllerDelegate {
    func onboardingViewControllerDidFinish() {
        showLoginViewController()
    }
}

extension OnboardingFlowCoordinator: LoginViewControllerDelegate {
    func loginViewControllerDidFinish() {
        showAgreementViewController()
    }
}

extension OnboardingFlowCoordinator: AgreementViewControllerDelegate {
    func agreementViewControllerDidFinish() {
        showNicknameViewController()
    }
}
