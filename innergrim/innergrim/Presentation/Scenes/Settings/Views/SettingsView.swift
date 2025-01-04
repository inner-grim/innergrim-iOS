//
//  SettingsView.swift
//  innergrim
//
//  Created by 지연 on 12/23/24.
//

import UIKit

// 임시
final class SettingsView: UIView {
    // MARK: - Components
    
    private lazy var termsLabel = makeLabel(with: "서비스 약관")
    
    let termsButton = SettingsButton(title: "이용 약관")
    
    let privacyPolicyButton = SettingsButton(title: "개인정보처리방침")
    
    let contactButton = SettingsButton(title: "문의하기")
    
    private lazy var accountLabel = makeLabel(with: "계정 관리")
    
    let logoutButton = SettingsButton(title: "로그아웃", isChevronHidden: true)
    
    let withdrawtButton = SettingsButton(title: "회원 탈퇴", isChevronHidden: true)
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Methods
    
    private func setupLayout() {
        addSubview(termsLabel)
        termsLabel.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().inset(16)
        }
        
        addSubview(termsButton)
        termsButton.snp.makeConstraints { make in
            make.top.equalTo(termsLabel.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(46)
        }
        
        addSubview(privacyPolicyButton)
        privacyPolicyButton.snp.makeConstraints { make in
            make.top.equalTo(termsButton.snp.bottom).offset(2)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(46)
        }
        
        addSubview(contactButton)
        contactButton.snp.makeConstraints { make in
            make.top.equalTo(privacyPolicyButton.snp.bottom).offset(2)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(46)
        }
        
        addSubview(accountLabel)
        accountLabel.snp.makeConstraints { make in
            make.top.equalTo(contactButton.snp.bottom).offset(44)
            make.leading.equalTo(16)
        }
        
        addSubview(logoutButton)
        logoutButton.snp.makeConstraints { make in
            make.top.equalTo(accountLabel.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(46)
        }
        
        addSubview(withdrawtButton)
        withdrawtButton.snp.makeConstraints { make in
            make.top.equalTo(logoutButton.snp.bottom).offset(2)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(46)
        }
    }
}

private extension SettingsView {
    func makeLabel(with text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.applyTypography(with: .labelSmallMedium)
        label.textColor = .labelAssistive
        return label
    }
}
