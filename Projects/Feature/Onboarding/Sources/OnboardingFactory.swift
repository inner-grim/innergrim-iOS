//
//  OnboardingFactory.swift
//  FeatureOnboarding
//
//  Created by 지연 on 10/15/24.
//

import UIKit

public final class OnboardingFactory {
    public init() {
        
    }
    
    public func makeLoginViewController() -> LoginViewController {
        return LoginViewController()
    }
}
