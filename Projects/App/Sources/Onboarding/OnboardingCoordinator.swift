//
//  OnboardingCoordinator.swift
//  FeatureOnboarding
//
//  Created by 지연 on 10/10/24.
//

import UIKit

import Feature
import Shared

protocol OnboardingCoordinatorDelegate: AnyObject {
    func onboardingCoordinatorDidFinish()
}

final class OnboardingCoordinator: Coordinator {
    private let window: UIWindow
    private let navigationController: UINavigationController
    private let factory: OnboardingFactory
    weak var delegate: OnboardingCoordinatorDelegate?
    
    init(window: UIWindow, factory: OnboardingFactory) {
        self.window = window
        self.navigationController = UINavigationController()
        self.factory = factory
    }
    
    func start() {
        navigationController.navigationBar.isHidden = true
        window.rootViewController = navigationController
        showOnboardingFirstViewController()
    }
    
    private func showOnboardingFirstViewController() {
        let viewController = factory.makeOnboardingFirstViewController()
        viewController.delegate = self
        navigationController.pushViewController(viewController, animated: true)
    }
    
    private func showOnboardingSecondViewController() {
        let viewController = factory.makeOnboardingSecondViewController()
        viewController.delegate = self
        navigationController.pushViewController(viewController, animated: true)
    }
    
    private func showOnboardingThirdViewController() {
        let viewController = factory.makeOnboardingThirdViewController()
        viewController.delegate = self
        navigationController.pushViewController(viewController, animated: true)
    }
    
    private func showLoginViewController() {
        let viewController = factory.makeLoginViewController()
        viewController.delegate = self
        navigationController.pushViewController(viewController, animated: true)
    }
    
    private func showAgreementViewController() {
        let viewController = factory.makeAgreementViewController()
        viewController.delegate = self
        navigationController.pushViewController(viewController, animated: true)
    }
    
    private func showNicknameViewController() {
        let viewController = factory.makeNicknameViewController()
        viewController.delegate = self
        navigationController.pushViewController(viewController, animated: true)
    }
    
    private func showGenderViewController() {
        let viewController = factory.makeGenderViewController()
        viewController.delegate = self
        navigationController.pushViewController(viewController, animated: true)
    }
}

// MARK: - Delegates

extension OnboardingCoordinator: OnboardingFirstViewControllerDelegate {
    func onboardingFirstViewControllerDidFinish() {
        showOnboardingSecondViewController()
    }
}

extension OnboardingCoordinator: OnboardingSecondViewControllerDelegate {
    func onboardingSecondViewControllerDidFinish() {
        showOnboardingThirdViewController()
    }
}

extension OnboardingCoordinator: OnboardingThirdViewControllerDelegate {
    func onboardingThirdViewControllerDidFinish() {
        showLoginViewController()
    }
}

extension OnboardingCoordinator: LoginViewControllerDelegate {
    func loginViewControllerDidFinish() {
        showAgreementViewController()
    }
}

extension OnboardingCoordinator: AgreementViewControllerDelegate {
    func agreementViewControllerDidFinish() {
        showNicknameViewController()
    }
}

extension OnboardingCoordinator: NicknameViewControllerDelegate {
    func nicknameViewControllerDidFinish() {
        showGenderViewController()
    }
}

extension OnboardingCoordinator: GenderViewControllerDelegate {
    func genderViewControllerDidFinish() {
        delegate?.onboardingCoordinatorDidFinish()
    }
}
