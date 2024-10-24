//
//  LoginViewController.swift
//  FeatureOnboarding
//
//  Created by 지연 on 10/10/24.
//

import Combine
import UIKit

public protocol LoginViewControllerDelegate: AnyObject {
    func loginViewControllerDidFinish()
}

public final class LoginViewController: UIViewController {
    private let viewModel: LoginViewModel
    private let loginView = LoginView()
    private var cancellables = Set<AnyCancellable>()
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
        bind()
        setupAction()
    }
}

// MARK: - Bind

private extension LoginViewController {
    func bind() {
        viewModel.state.loginResult
            .receive(on: DispatchQueue.main)
            .sink { [weak self] isLoginSuccess in
                if isLoginSuccess {
                    self?.delegate?.loginViewControllerDidFinish()
                } else {
                    // TODO: Alert
                }
            }
            .store(in: &cancellables)
    }
}

// MARK: - Setup Methods

private extension LoginViewController {
    func setupAction() {
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
}

// MARK: - Action Methods
private extension LoginViewController {
    @objc func handleKakaoLoginButtonTap() {
        viewModel.send(.loginButtonTap(.kakao))
    }
    
    @objc func handleAppleLoginButtonTap() {
        viewModel.send(.loginButtonTap(.apple))
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
