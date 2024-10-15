//
//  OnboardingFactory.swift
//  FeatureOnboarding
//
//  Created by 지연 on 10/15/24.
//

import UIKit

import Domain

public final class OnboardingFactory {
    private let loginUseCase: OAuthLoginUseCase
    
    public init(loginUseCase: OAuthLoginUseCase) {
        self.loginUseCase = loginUseCase
    }
    
    public func makeLoginViewController() -> LoginViewController {
        let viewModel = LoginViewModel(loginUseCase: loginUseCase)
        return LoginViewController(viewModel: viewModel)
    }
}
