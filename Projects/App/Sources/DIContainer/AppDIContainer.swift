//
//  AppDIContainer.swift
//  innergrim
//
//  Created by 지연 on 11/23/24.
//

import Foundation

import Core
import Domain

final class AppDIContainer {
    private let networkService: NetworkServiceProtocol
    private let keychainService: KeychainServiceProtocol
    private let loginUseCase: OAuthLoginUseCaseProtocol
    
    init() {
        networkService = NetworkService()
        keychainService = KeychainService()
        loginUseCase = OAuthUseCase(
            loginServices: [KakaoLoginService(), AppleLoginService(), GoogleLoginService()],
            networkService: networkService,
            keychainService: keychainService
        )
    }
    
    // MARK: - DIContainers of scenes
    
    func makeOnboardingDIContainer() -> OnboardingDIContainer {
        let dependencies = OnboardingDIContainer.Dependencies(
            loginUseCase: loginUseCase
        )
        return OnboardingDIContainer(dependencies: dependencies)
    }
    
    func makeMainDIContainer() -> MainDIContainer {
        let dependencies = MainDIContainer.Dependencies()
        return MainDIContainer(dependencies: dependencies)
    }
}
