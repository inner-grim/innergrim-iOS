//
//  LoginViewController.swift
//  FeatureOnboarding
//
//  Created by 지연 on 10/10/24.
//

import Combine
import UIKit

import Shared

public protocol LoginViewControllerDelegate: AnyObject {
    func loginViewControllerDidFinish()
}

public final class LoginViewController: BaseViewController<LoginView> {
    public weak var delegate: LoginViewControllerDelegate?
    private let viewModel: LoginViewModel
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Init
    
    public init(viewModel: LoginViewModel) {
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
        setupBindings()
    }
    
    // MARK: - Setup Methods
    
    func setupBindings() {
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

private extension LoginViewController {
    var kakaoLoginButton: UIButton {
        contentView.kakaoLoginButton
    }
    
    var appleLoginButton: UIButton {
        contentView.appleLoginButton
    }
}
