//
//  LoginViewController.swift
//  Onboarding
//
//  Created by 지연 on 11/23/24.
//

import Combine
import UIKit

import FeatureOnboardingInterface
import Shared

public final class LoginViewController: BaseViewController<LoginView> {
    public weak var delegate: LoginViewControllerDelegate?
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Lifecycle
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBarHidden()
        setupBindings()
    }
    
    // MARK: - Setup Methods
    
    private func setupBindings() {
        // action
        kakaoLoginButton.tapPublisher
            .sink { [weak self] in
                self?.delegate?.loginViewControllerDidFinish()
            }
            .store(in: &cancellables)
        
        appleLoginButton.tapPublisher
            .sink { [weak self] in
                self?.delegate?.loginViewControllerDidFinish()
            }
            .store(in: &cancellables)
        
        googleLoginButton.tapPublisher
            .sink { [weak self] in
                self?.delegate?.loginViewControllerDidFinish()
            }
            .store(in: &cancellables)
    }
}

private extension LoginViewController {
    var kakaoLoginButton: UIButton {
        contentView.kakaoLoginButton
    }
    
    var appleLoginButton: UIButton {
        contentView.appleLoginButton
    }
    
    var googleLoginButton: UIButton {
        contentView.googleLoginButton
    }
}
