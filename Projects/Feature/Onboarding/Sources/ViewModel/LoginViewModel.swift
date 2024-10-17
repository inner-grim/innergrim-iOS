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
    // MARK: - Action
    
    public enum Action {
        case loginButtonTap(OAuthProvider)
    }
    
    // MARK: - State
    
    public struct State {
        var loginResult: PassthroughSubject<Bool, Never>
    }
    
    // MARK: - Property
    
    private let loginUseCase: OAuthLoginUseCase
    private let keychainStorage: KeyChainStorage
    
    private(set) var state: State
    private let actionSubject = PassthroughSubject<Action, Never>()
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Init
    
    public init(loginUseCase: OAuthLoginUseCase, keychainStorage: KeyChainStorage) {
        self.loginUseCase = loginUseCase
        self.keychainStorage = keychainStorage
        self.state = State(loginResult: .init())
        
        actionSubject
            .sink { [weak self] action in
                self?.handleAction(action)
            }
            .store(in: &cancellables)
    }
    
    // MARK: - Handle Action Methods
    
    public func send(_ action: Action) {
        actionSubject.send(action)
    }
    
    private func handleAction(_ action: Action) {
        switch action {
        case let .loginButtonTap(provider):
            login(provider: provider)
        }
    }
    
    private func login(provider: OAuthProvider) {
        loginUseCase.login(with: provider)
            .catch { error -> AnyPublisher<OAuthResult, Never> in
                return Just(OAuthResult.failure(error)).eraseToAnyPublisher()
            }
            .sink { [weak self] result in
                guard let self = self else { return }
                switch result {
                case let .success(authData):
                    do {
                        try keychainStorage.save(authData.id, for: .socialID)
                        try keychainStorage.save(authData.provider.rawValue, for: .socialProvider)
                        state.loginResult.send(true)
                    } catch {
                        print("인증 데이터 로컬 스토리지 저장 실패")
                    }
                case let .failure(authError):
                    print("로그인 실패: \(authError)")
                    state.loginResult.send(false)
                }
            }
            .store(in: &cancellables)
    }
}
