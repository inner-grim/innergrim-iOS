//
//  OnboardingDIContainer.swift
//  innergrim
//
//  Created by 지연 on 11/23/24.
//

import UIKit

import Feature

public final class OnboardingDIContainer {
    struct Dependencies {}

    private let dependencies: Dependencies

    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    // MARK: - View Models

    // MARK: - View Controllers
    
    func makeOnboardingViewController() -> OnboardingViewController {
        let viewController = OnboardingViewController()
        return viewController
    }
    
    func makeLoginViewController() -> LoginViewController {
        let viewController = LoginViewController()
        return viewController
    }
    
    func makeAgreementViewController() -> AgreementViewController {
        let viewController = AgreementViewController()
        return viewController
    }
    
    func makeNicknameViewController() -> NicknameViewController {
        let viewController = NicknameViewController()
        return viewController
    }
    
    func makeGenderViewController() -> GenderViewController {
        let viewController = GenderViewController()
        return viewController
    }
}
