//
//  LoginViewController.swift
//  innergrim
//
//  Created by 지연 on 12/19/24.
//

import Combine
import UIKit

protocol LoginViewControllerDelegate: AnyObject {
    func loginViewControllerDidFinish()
}

final class LoginViewController: BaseViewController<LoginView> {
    weak var delegate: LoginViewControllerDelegate?
    private let viewModel: LoginViewModel
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Init
    
    init(viewModel: LoginViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
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
                guard let self = self else { return }
                generateHaptic()
                viewModel.send(.loginButtonDidTap(.kakao))
            }
            .store(in: &cancellables)
        
        appleLoginButton.tapPublisher
            .sink { [weak self] in
                guard let self = self else { return }
                generateHaptic()
                viewModel.send(.loginButtonDidTap(.apple))
            }
            .store(in: &cancellables)
        
        googleLoginButton.tapPublisher
            .sink { [weak self] in
                guard let self = self else { return }
                generateHaptic()
                viewModel.send(.loginButtonDidTap(.google))
            }
            .store(in: &cancellables)
        
        // state
        viewModel.state.loginResult
            .receive(on: RunLoop.main)
            .sink { [weak self] result in
                guard let self = self else { return }
                if result {
                    delegate?.loginViewControllerDidFinish()
                } else {
                    showAlert(
                        title: "로그인 오류",
                        message: "일시적인 오류가 발생했습니다.\n잠시 후 다시 시도해 주세요.",
                        rightActionText: "확인"
                    )
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
