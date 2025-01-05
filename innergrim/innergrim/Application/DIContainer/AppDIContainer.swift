//
//  AppDIContainer.swift
//  innergrim
//
//  Created by 지연 on 12/19/24.
//

import Foundation

final class AppDIContainer {
    // MARK: - DIContainers of scenes
    
    func makeOnboardingDIContainer() -> OnboardingDIContainer {
        return OnboardingDIContainer()
    }
    
    func makeMainDIContainer() -> MainDIContainer {
        return MainDIContainer()
    }
}
