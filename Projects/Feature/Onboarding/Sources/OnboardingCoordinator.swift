//
//  OnboardingCoordinator.swift
//  FeatureOnboarding
//
//  Created by 지연 on 10/10/24.
//

import UIKit

import Shared

public protocol OnboardingCoordinatorDelegate: AnyObject {
    func onboardingCoordinatorDidFinish()
}

public final class OnboardingCoordinator: Coordinator {
    private let window: UIWindow
    private let navigationController: UINavigationController
    private let factory: OnboardingFactory
    public weak var delegate: OnboardingCoordinatorDelegate?
    
    public init(window: UIWindow, factory: OnboardingFactory) {
        self.window = window
        self.navigationController = UINavigationController()
        self.factory = factory
    }
    
    public func start() {
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
}

extension OnboardingCoordinator: OnboardingFirstViewControllerDelegate {
    public func onboardingFirstViewControllerDidFinish() {
        showOnboardingSecondViewController()
    }
}

extension OnboardingCoordinator: OnboardingSecondViewControllerDelegate {
    public func onboardingSecondViewControllerDidFinish() {
        showOnboardingThirdViewController()
    }
}

extension OnboardingCoordinator: OnboardingThirdViewControllerDelegate {
    public func onboardingThirdViewControllerDidFinish() {
        showLoginViewController()
    }
}

extension OnboardingCoordinator: LoginViewControllerDelegate {
    public func loginViewControllerDidFinish() {
        delegate?.onboardingCoordinatorDidFinish()
    }
}
