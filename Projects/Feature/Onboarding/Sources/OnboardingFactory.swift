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
    
    public init(loginUseCase: OAuthLoginUseCase, networkService: NetworkService) {
        self.loginUseCase = loginUseCase
        self.networkService = networkService
    }
    
    public func makeLoginViewController() -> LoginViewController {
        let viewModel = LoginViewModel(loginUseCase: loginUseCase)
        return LoginViewController(viewModel: viewModel)
    }
}
