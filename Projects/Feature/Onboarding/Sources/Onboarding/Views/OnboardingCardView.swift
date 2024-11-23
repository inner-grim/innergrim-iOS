//
//  OnboardingCardView.swift
//  Onboarding
//
//  Created by 지연 on 11/23/24.
//

import UIKit

import Shared

import UIKit

public final class OnboardingCardView: UIStackView {
    // MARK: - Components
    
    private let titleLabel = {
        let label = UILabel()
        label.textColor = .labelNormal
        label.textAlignment = .center
        label.numberOfLines = 2
        return label
    }()
    
    private let imageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .fillAssistive
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    // MARK: - Init
    
    public init(title: String, image: UIImage?) {
        super.init(frame: .zero)
        setupStackView(title: title, image: image)
        setupLayout()
    }
    
    @available(*, unavailable)
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Methods
    
    private func setupStackView(title: String, image: UIImage?) {
        // 텍스트
        titleLabel.text = title
        titleLabel.applyTypography(with: .titleLarge)
        // 이미지
        imageView.image = image
        // 스택 뷰
        axis = .vertical
        spacing = 20
        alignment = .center
    }
    
    private func setupLayout() {
        [titleLabel, imageView].forEach { addArrangedSubview($0) }
        
        imageView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
        }
    }
}
