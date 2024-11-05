//
//  LoginView.swift
//  FeatureOnboarding
//
//  Created by 지연 on 10/10/24.
//

import UIKit

import Shared

public final class LoginView: UIView {
    // MARK: - Components
    
    lazy var kakaoLoginButton = SocialLoginButton(socialType: .kakao)
    
    lazy var appleLoginButton = SocialLoginButton(socialType: .apple)
    
    lazy var googleLoginButton = SocialLoginButton(socialType: .goole)
    
    private let buttonContainer = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 8
        return stackView
    }()
    
    // MARK: - Initialize
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Methods
    
    private func setupUI() {
        backgroundColor = .systemBackground
        
        addSubview(buttonContainer)
        buttonContainer.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().inset(48)
            make.height.equalTo(166) // 버튼 높이: 50, 간격: 8
        }
        
        buttonContainer.addArrangedSubview(kakaoLoginButton)
        buttonContainer.addArrangedSubview(appleLoginButton)
        buttonContainer.addArrangedSubview(googleLoginButton)
    }
}

private extension LoginView {
    func createButton(_ title: String) -> UIButton {
        let button = UIButton()
        button.configuration = .tinted()
        button.configuration?.title = title
        button.clipsToBounds = true
        button.layer.cornerRadius = 8
        return button
    }
}
