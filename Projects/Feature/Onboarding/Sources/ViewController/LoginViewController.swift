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
    private let viewModel: LoginViewModel
    private let loginView = LoginView()
    weak var delegate: LoginViewControllerDelegate?
    
    // MARK: - Init
    
    init(viewModel: LoginViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
        viewModel.login(provider: .kakao)
    }
    
    @objc private func handleAppleLoginButtonTap() {
        viewModel.login(provider: .apple)
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
