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
    private let factory: OnboardingFactory
    public weak var delegate: OnboardingCoordinatorDelegate?
    
    public init(window: UIWindow, factory: OnboardingFactory) {
        self.window = window
        self.factory = factory
    }
    
    public func start() {
        showLoginViewController()
    }
    
    private func showLoginViewController() {
        let loginViewController = factory.makeLoginViewController()
        loginViewController.delegate = self
        window.rootViewController = UINavigationController(rootViewController: loginViewController)
    }
}

extension OnboardingCoordinator: LoginViewControllerDelegate {
    public func loginViewControllerDidFinish() {
        delegate?.onboardingCoordinatorDidFinish()
    }
}
