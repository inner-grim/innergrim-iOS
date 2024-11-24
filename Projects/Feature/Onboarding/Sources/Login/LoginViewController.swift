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
    private let viewModel: LoginViewModel
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Init
    
    public init(viewModel: LoginViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
                self?.viewModel.send(.loginButtonTap(.kakao))
            }
            .store(in: &cancellables)
        
        appleLoginButton.tapPublisher
            .sink { [weak self] in
                self?.viewModel.send(.loginButtonTap(.apple))
            }
            .store(in: &cancellables)
        
        // state
        viewModel.state.loginResult
            .receive(on: RunLoop.main)
            .sink { [weak self] result in
                if result {
                    self?.delegate?.loginViewControllerDidFinish()
                }
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
