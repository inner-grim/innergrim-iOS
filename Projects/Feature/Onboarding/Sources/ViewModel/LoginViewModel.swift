//
//  LoginViewModel.swift
//  FeatureOnboarding
//
//  Created by 지연 on 10/15/24.
//

import Combine
import Foundation

import Core
import Domain

public final class LoginViewModel {
    private let loginUseCase: OAuthLoginUseCase
    private var cancellables = Set<AnyCancellable>()
    
    public init(loginUseCase: OAuthLoginUseCase) {
        self.loginUseCase = loginUseCase
    }
    
    public func login(provider: OAuthProvider) {
        loginUseCase.login(with: provider)
            .catch { error -> AnyPublisher<OAuthResult, Never> in
                return Just(OAuthResult.failure(error)).eraseToAnyPublisher()
            }
            .sink { string in
                print("정체가 뭐니? \(string)")
            }
            .store(in: &cancellables)
    }
}
