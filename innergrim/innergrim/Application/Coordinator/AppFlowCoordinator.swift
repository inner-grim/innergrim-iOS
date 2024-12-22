//
//  AppFlowCoordinator.swift
//  innergrim
//
//  Created by 지연 on 12/19/24.
//

import UIKit

final class AppFlowCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    private let window: UIWindow
    private let appDIContainer: AppDIContainer
    
    init(
        window: UIWindow,
        appDIContainer: AppDIContainer
    ) {
        self.window = window
        self.appDIContainer = appDIContainer
    }
    
    func start() {
        if needsOnboarding() {
            showOnboardingFlow()
        } else {
            showMainFlow()
        }
    }
    
    private func needsOnboarding() -> Bool {
//        return !UserDataStorage.isOnboardingCompleted
//        return true
        return false
    }
    
    private func showOnboardingFlow() {
        let navigationController = UINavigationController()
        window.rootViewController = navigationController
        
        let onboardingDIContainer = appDIContainer.makeOnboardingDIContainer()
        
        let onboardingCoordinator = OnboardingFlowCoordinator(
            navigationController: navigationController,
            onboardingDIContainer: onboardingDIContainer
        )
        
        onboardingCoordinator.delegate = self
        store(coordinator: onboardingCoordinator)
        onboardingCoordinator.start()
    }
    
    private func showMainFlow() {
        let navigationController = UINavigationController()
        window.rootViewController = navigationController
        
        let mainDIContainer = appDIContainer.makeMainDIContainer()
        
        let mainCoordinator = MainFlowCoordinator(
            navigationController: navigationController,
            mainDIContainer: mainDIContainer
        )
        
        store(coordinator: mainCoordinator)
        mainCoordinator.start()
    }
}

extension AppFlowCoordinator: OnboardingFlowCoordinatorDelegate {
    func onboardingFlowDidFinish(_ coordinator: OnboardingFlowCoordinator) {
        UserDataStorage.isOnboardingCompleted = true
        free(coordinator: coordinator)
        showMainFlow()
    }
}
