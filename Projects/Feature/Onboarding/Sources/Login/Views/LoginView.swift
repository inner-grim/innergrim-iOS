//
//  LoginView.swift
//  Onboarding
//
//  Created by 지연 on 11/23/24.
//

import UIKit

import Shared

public final class LoginView: UIView {
    // MARK: - Components
    
    private let imageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .fillAssistive
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let loginButtonStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8.0
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    let kakaoLoginButton = LoginButton(socialType: .kakao)
        
    let appleLoginButton = LoginButton(socialType: .apple)
        
    let googleLoginButton = LoginButton(socialType: .goole)
    
    // MARK: - Init
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Methods
    
    private func setupLayout() {
        addSubview(loginButtonStackView)
        loginButtonStackView.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(48)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(166)// 버튼 높이: 50, 간격: 8
        }
        
        [kakaoLoginButton, appleLoginButton, googleLoginButton]
            .forEach { loginButtonStackView.addArrangedSubview($0) }
        
        addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(20)
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalTo(loginButtonStackView.snp.top).offset(-20)
        }
    }
}
