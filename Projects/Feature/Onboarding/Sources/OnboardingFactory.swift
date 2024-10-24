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
    
    public func makeLoginViewController() -> LoginViewController {
        let viewModel = LoginViewModel(
            loginUseCase: loginUseCase,
            keychainStorage: keychainStorage
        )
        return LoginViewController(viewModel: viewModel)
    }
}
