//
//  AppCoordinator.swift
//  innergrim
//
//  Created by 지연 on 10/10/24.
//

import UIKit

import Core
import Domain
import Feature
import Shared

class AppCoordinator: Coordinator {
    private let window: UIWindow
    
    private let networkService: NetworkService
    private let keychainStorage: KeyChainStorage
    
    private var onboardingCoordinator: Coordinator?
    private var mainCoordinator: Coordinator?

    init(window: UIWindow) {
        self.window = window
        self.networkService = NetworkServiceImpl.shared
        self.keychainStorage = Keychain.shared
    }

    func start() {
        if needsOnboarding() {
            showOnboarding()
        } else {
            showMain()
        }
    }

    private func needsOnboarding() -> Bool {
        // TODO: 온보딩 필요 여부 확인 로직
        return true
    }

    private func showOnboarding() {
        let loginServices: [OAuthLoginService] = [
            KakaoLoginService(),
            AppleLoginService(),
            GoogleLoginService()
        ]
        let loginUseCase = OAuthUseCaseImpl(
            loginServices: loginServices,
            networkService: networkService
        )
        let onboardingCoordinator = OnboardingCoordinator(
            window: window,
            factory: OnboardingFactory(
                loginUseCase: loginUseCase,
                networkService: networkService,
                keychainStorage: keychainStorage
            )
        )
        onboardingCoordinator.delegate = self
        onboardingCoordinator.start()
        self.onboardingCoordinator = onboardingCoordinator
    }

    private func showMain() {
        let mainCoordinator = MainCoordinator(
            window: window,
            factory: MainFactory()
        )
        mainCoordinator.start()
        self.mainCoordinator = mainCoordinator
    }
}

extension AppCoordinator: OnboardingCoordinatorDelegate {
    func onboardingCoordinatorDidFinish() {
        showMain()
    }
}
