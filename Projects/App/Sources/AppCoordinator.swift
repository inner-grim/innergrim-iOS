//
//  AppCoordinator.swift
//  innergrim
//
//  Created by 지연 on 10/10/24.
//

import UIKit

import Feature
import Shared

class AppCoordinator: Coordinator {
    private let window: UIWindow
    private var onboardingCoordinator: Coordinator?
    private var mainCoordinator: Coordinator?

    init(window: UIWindow) {
        self.window = window
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
        let onboardingCoordinator = OnboardingCoordinator(
            window: window,
            factory: OnboardingFactory()
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
