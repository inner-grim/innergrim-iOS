//
//  OnboardingDIContainer.swift
//  innergrim
//
//  Created by 지연 on 11/23/24.
//

import UIKit

import Domain
import Feature

public final class OnboardingDIContainer {
    struct Dependencies {
        public let loginUseCase: OAuthLoginUseCaseProtocol
    }

    private let dependencies: Dependencies

    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    // MARK: - View Models
    
    private func makeLoginViewModel() -> LoginViewModel {
        let viewModel = LoginViewModel(loginUseCase: dependencies.loginUseCase)
        return viewModel
    }

    // MARK: - View Controllers
    
    func makeOnboardingViewController() -> OnboardingViewController {
        let viewController = OnboardingViewController()
        return viewController
    }
    
    func makeLoginViewController() -> LoginViewController {
        let viewModel = makeLoginViewModel()
        let viewController = LoginViewController(viewModel: viewModel)
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
