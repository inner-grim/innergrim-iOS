//
//  LoginViewController.swift
//  FeatureOnboarding
//
//  Created by 지연 on 10/10/24.
//

import UIKit

public protocol LoginViewControllerDelegate: AnyObject {
    func loginViewControllerDidFinish()
}

public final class LoginViewController: UIViewController {
    private let loginView = LoginView()
    weak var delegate: LoginViewControllerDelegate?
    
    // MARK: - Life Cycle
    
    public override func loadView() {
        view = loginView
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupAction()
    }
    
    // MARK: - Action Methods
    
    private func setupAction() {
        kakaoLoginButton.addTarget(
            self,
            action: #selector(handleKakaoLoginButtonTap),
            for: .touchUpInside
        )
        
        appleLoginButton.addTarget(
            self,
            action: #selector(handleAppleLoginButtonTap),
            for: .touchUpInside
        )
    }
    
    @objc private func handleKakaoLoginButtonTap() {
        print("카카오")
//        delegate?.loginViewControllerDidFinish()
    }
    
    @objc private func handleAppleLoginButtonTap() {
        print("애플")
        delegate?.loginViewControllerDidFinish()
    }
}

private extension LoginViewController {
    var kakaoLoginButton: UIButton {
        loginView.kakaoLoginButton
    }
    
    var appleLoginButton: UIButton {
        loginView.appleLoginButton
    }
}
