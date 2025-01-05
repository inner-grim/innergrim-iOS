//
//  LoginButton.swift
//  innergrim
//
//  Created by 지연 on 12/19/24.
//

import UIKit

final class LoginButton: UIButton {
    // MARK: - Components
    
    private let socialImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let socialLabel = UILabel()
    
    // MARK: - Init
    
    init(socialType: SocialType) {
        super.init(frame: .zero)
        setupButton(with: socialType)
        setupLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Methods
    
    private func setupButton(with socialType: SocialType) {
        // 이미지
        socialImageView.image = socialType.image
        // 타이틀
        socialLabel.text = "\(socialType.description)로 계속하기"
        socialLabel.applyTypography(with: .labelLargeSemiBold)
        socialLabel.textColor = socialType.textColor
        // 레이어
        layer.cornerRadius = 8.0
        layer.borderWidth = 1.0
        layer.borderColor = socialType.borderColor.cgColor
        backgroundColor = socialType.backgroundColor
    }
    
    private func setupLayout() {
        addSubview(socialImageView)
        socialImageView.snp.makeConstraints { make in
            make.width.height.equalTo(20)
            make.leading.equalToSuperview().inset(16)
            make.centerY.equalToSuperview()
        }
        
        addSubview(socialLabel)
        socialLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}
