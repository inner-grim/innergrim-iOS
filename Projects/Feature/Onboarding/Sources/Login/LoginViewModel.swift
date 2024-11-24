//
//  LoginViewModel.swift
//  Onboarding
//
//  Created by 지연 on 11/24/24.
//

import Combine
import Foundation

import Core
import Domain
import Shared

public final class LoginViewModel: ViewModel {
    public enum Action {
        case loginButtonTap(OAuthProvider)
    }
    
    public struct State {
        var loginResult: PassthroughSubject<Bool, Never>
    }
    
    // MARK: - Properties
    
    public var actionSubject = PassthroughSubject<Action, Never>()
    public var cancellables = Set<AnyCancellable>()
    public var state: State
    
    private let loginUseCase: OAuthLoginUseCaseProtocol
    
    // MARK: - Init
    
    public init(loginUseCase: OAuthLoginUseCaseProtocol) {
        self.loginUseCase = loginUseCase
        self.state = State(loginResult: .init())
        
        setupActionBindings()
    }
    
    private func setupActionBindings() {
        actionSubject.sink { [weak self] action in
            switch action {
            case .loginButtonTap(let provider):
                self?.login(provider: provider)
            }
        }
        .store(in: &cancellables)
    }
    
    private func login(provider: OAuthProvider) {
        loginUseCase.login(with: provider)
            .sink { [weak self] completion in
                switch completion {
                case .finished:
                    self?.state.loginResult.send(true)
                case .failure:
                    self?.state.loginResult.send(false)
                }
            } receiveValue: { result in
                print("👩🏻‍💻 로그인 플로우 완료: \(result)")
            }
            .store(in: &cancellables)
    }
}
