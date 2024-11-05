//
//  OnboardingFactory.swift
//  FeatureOnboarding
//
//  Created by 지연 on 10/15/24.
//

import UIKit

import Core
import Domain

public final class OnboardingFactory {
    private let loginUseCase: OAuthLoginUseCase
    private let networkService: NetworkService
    private let keychainStorage: KeyChainStorage
    
    public init(
        loginUseCase: OAuthLoginUseCase,
        networkService: NetworkService,
        keychainStorage: KeyChainStorage
    ) {
        self.loginUseCase = loginUseCase
        self.networkService = networkService
        self.keychainStorage = keychainStorage
    }
    
    public func makeOnboardingFirstViewController() -> OnboardingFirstViewController {
        return OnboardingFirstViewController()
    }
    
    public func makeOnboardingSecondViewController() -> OnboardingSecondViewController {
        return OnboardingSecondViewController()
    }
    
    public func makeOnboardingThirdViewController() -> OnboardingThirdViewController {
        return OnboardingThirdViewController()
    }
    
    public func makeLoginViewController() -> LoginViewController {
        let viewModel = LoginViewModel(
            loginUseCase: loginUseCase,
            keychainStorage: keychainStorage
        )
        return LoginViewController(viewModel: viewModel)
    }
    
    public func makeAgreementViewController() -> AgreementViewController {
        return AgreementViewController()
    }
    
    public func makeNicknameViewController() -> NicknameViewController {
        return NicknameViewController()
    }
    
    public func makeGenderViewController() -> GenderViewController {
        return GenderViewController()
    }
}
