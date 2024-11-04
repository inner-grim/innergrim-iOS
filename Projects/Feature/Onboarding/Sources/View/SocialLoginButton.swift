//
//  SocialLoginButton.swift
//  FeatureOnboarding
//
//  Created by 지연 on 11/5/24.
//

import UIKit

import Shared
import SnapKit

public final class SocialLoginButton: UIButton {
    // MARK: - Components
    
    private let socialImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let socialTitleLabel = {
        let label = UILabel()
        label.applyTypography(with: .labelLargeSemiBold)
        return label
    }()
    
    // MARK: - Init
    
    public init(socialType: SocialType) {
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
        socialImageView.image = socialType.image
        socialImageView.tintColor = socialType.textColor
        
        socialTitleLabel.text = "\(socialType.rawValue)로 계속하기"
        socialTitleLabel.textColor = socialType.textColor
        
        backgroundColor = socialType.backgroundColor
        
        layer.borderWidth = 1
        layer.borderColor = socialType.borderColor.cgColor
        
        layer.cornerRadius = 8
    }
    
    private func setupLayout() {
        addSubview(socialImageView)
        socialImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(16)
            make.centerY.equalToSuperview()
        }
        
        addSubview(socialTitleLabel)
        socialTitleLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}
