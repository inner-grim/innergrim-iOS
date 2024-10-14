//
//  OnboardingFactory.swift
//  FeatureOnboarding
//
//  Created by 지연 on 10/15/24.
//

import UIKit

import Domain

public final class OnboardingFactory {
    private let authUseCase: AuthUseCase
    
    public init(authUseCase: AuthUseCase) {
        self.authUseCase = authUseCase
    }
    
    public func makeLoginViewController() -> LoginViewController {
        let viewModel = LoginViewModel(authUseCase: authUseCase)
        return LoginViewController(viewModel: viewModel)
    }
}
