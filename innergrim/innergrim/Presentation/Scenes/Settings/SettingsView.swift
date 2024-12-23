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
    
    private let accountLabel = {
        let label = UILabel()
        label.text = "계정 관리"
        label.applyTypography(with: .labelSmallMedium)
        label.textColor = .labelAssistive
        return label
    }()
    
    let logoutButton = {
        let button = UIButton()
        let attributedTitle = NSAttributedString(
            string: "로그아웃",
            attributes: [.font: UIFont.bodyLargeSemiBold]
        )
        button.setAttributedTitle(attributedTitle, for: .normal)
        button.contentHorizontalAlignment = .leading
        button.tintColor = .labelNormal
        return button
    }()
    
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
        addSubview(accountLabel)
        accountLabel.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().inset(16)
        }
        
        addSubview(logoutButton)
        logoutButton.snp.makeConstraints { make in
            make.top.equalTo(accountLabel.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(46)
        }
    }
}
