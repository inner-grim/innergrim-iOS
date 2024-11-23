//
//  OnboardingDIContainer.swift
//  innergrim
//
//  Created by 지연 on 11/23/24.
//

import UIKit

import Feature

final class OnboardingDIContainer {
    struct Dependencies {}

    private let dependencies: Dependencies

    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    // MARK: - View Models

    // MARK: - View Controllers
    
    public func makeOnboardingViewController() -> OnboardingViewController {
        let viewController = OnboardingViewController()
        return viewController
    }
    
    public func makeLoginViewController() -> LoginViewController {
        let viewController = LoginViewController()
        return viewController
    }
}
