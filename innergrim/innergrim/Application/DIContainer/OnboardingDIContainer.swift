//
//  OnboardingDIContainer.swift
//  innergrim
//
//  Created by 지연 on 12/19/24.
//

import UIKit

final class OnboardingDIContainer {
    // MARK: - View Models
    
//    private func makeLoginViewModel() -> LoginViewModel {
//        return LoginViewModel()
//    }
//    
//    private func makeNicknameViewModel() -> NicknameViewModel {
//        return NicknameViewModel()
//    }

    // MARK: - View Controllers
    
    func makeLoginViewController() -> LoginViewController {
        let viewController = LoginViewController()
        return viewController
    }
    
    func makeNicknameViewController() -> NicknameViewController {
        let viewController = NicknameViewController()
        return viewController
    }
}
