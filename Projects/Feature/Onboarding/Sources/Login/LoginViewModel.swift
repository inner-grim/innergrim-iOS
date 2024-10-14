//
//  LoginViewModel.swift
//  FeatureOnboarding
//
//  Created by 지연 on 10/15/24.
//

import Combine
import Foundation

import Domain

public final class LoginViewModel {
    private let authUseCase: AuthUseCase
    private var cancellables = Set<AnyCancellable>()
    
    public init(authUseCase: AuthUseCase) {
        self.authUseCase = authUseCase
    }
    
    public func login(provider: AuthProvider) {
        authUseCase.login(with: provider)
            .sink { completion in
                switch completion {
                case .finished:
                    print("finished")
                case .failure(let authError):
                    print("failed: \(authError)")
                }
            } receiveValue: { userEntity in
                print(userEntity)
            }.store(in: &cancellables)
    }
}
