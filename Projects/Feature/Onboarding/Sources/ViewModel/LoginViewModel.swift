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
    private let loginUseCase: OAuthLoginUseCase
    private var cancellables = Set<AnyCancellable>()
    
    public init(loginUseCase: OAuthLoginUseCase) {
        self.loginUseCase = loginUseCase
    }
    
    public func login(provider: OAuthProvider) {
        loginUseCase.login(with: provider)
            .flatMap { [weak self] result -> AnyPublisher<String, OAuthError> in
                guard let self = self else {
                    return Fail(error: .unknown).eraseToAnyPublisher()
                }
                return self.createUser(with: result)
            }
            .receive(on: DispatchQueue.main)
            .sink { completion in
                if case .failure(let error) = completion {
                    print("failed: \(error)")
                }
            } receiveValue: { accessToken in
                print("accessToken = \(accessToken)")
            }
            .store(in: &cancellables)
    }
    
    private func createUser(with userEntity: UserEntity) -> AnyPublisher<String, OAuthError> {
        // TODO: 회원생성
        Future<String, OAuthError> { promise in
            DispatchQueue.global().asyncAfter(deadline: .now() + 2) {
                promise(.success("newAccessToken"))
            }
        }
        .eraseToAnyPublisher()
    }
}
