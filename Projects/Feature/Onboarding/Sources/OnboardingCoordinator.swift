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
    public weak var delegate: OnboardingCoordinatorDelegate?
    
    public init(window: UIWindow) {
        self.window = window
    }
    
    public func start() {
        showLoginViewController()
        window.makeKeyAndVisible()
    }
    
    private func showLoginViewController() {
        let loginViewController = LoginViewController()
        loginViewController.delegate = self
        window.rootViewController = UINavigationController(rootViewController: loginViewController)
    }
}

extension OnboardingCoordinator: LoginViewControllerDelegate {
    public func loginViewControllerDidFinish() {
        delegate?.onboardingCoordinatorDidFinish()
    }
}
