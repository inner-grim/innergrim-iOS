//
//  OnboardingFactory.swift
//  FeatureOnboarding
//
//  Created by 지연 on 10/15/24.
//

import UIKit

import Core
import Domain
import Feature

final class OnboardingFactory {
    private let loginUseCase: OAuthLoginUseCase
    private let networkService: NetworkService
    private let keychainStorage: KeyChainStorage
    
    init(
        loginUseCase: OAuthLoginUseCase,
        networkService: NetworkService,
        keychainStorage: KeyChainStorage
    ) {
        self.loginUseCase = loginUseCase
        self.networkService = networkService
        self.keychainStorage = keychainStorage
    }
    
    func makeOnboardingFirstViewController() -> OnboardingFirstViewController {
        return OnboardingFirstViewController()
    }
    
    func makeOnboardingSecondViewController() -> OnboardingSecondViewController {
        return OnboardingSecondViewController()
    }
    
    func makeOnboardingThirdViewController() -> OnboardingThirdViewController {
        return OnboardingThirdViewController()
    }
    
    func makeLoginViewController() -> LoginViewController {
        let viewModel = LoginViewModel(
            loginUseCase: loginUseCase,
            keychainStorage: keychainStorage
        )
        return LoginViewController(viewModel: viewModel)
    }
    
    func makeAgreementViewController() -> AgreementViewController {
        return AgreementViewController()
    }
    
    func makeNicknameViewController() -> NicknameViewController {
        return NicknameViewController()
    }
    
    func makeGenderViewController() -> GenderViewController {
        return GenderViewController()
    }
}
