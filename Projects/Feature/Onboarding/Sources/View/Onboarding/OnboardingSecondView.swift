//
//  OnboardingSecondView.swift
//  FeatureOnboarding
//
//  Created by 지연 on 11/5/24.
//

import UIKit

import Shared
import SnapKit

public final class OnboardingSecondView: UIView {
    // MARK: - Components
    
    private let label = {
        let label = UILabel()
        label.text = "오늘의 하루를\n그려주세요"
        label.applyTypography(with: .titleLarge)
        label.textColor = .labelNormal
        label.numberOfLines = 2
        label.textAlignment = .center
        return label
    }()
    
    private let imageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .fillAssistive
        return imageView
    }()
    
    private let buttonContainer = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 8
        return stackView
    }()
    
    let prevButton = AssistiveButton(title: "뒤로", font: .labelLargeSemiBold)
    
    let nextButton = SolidButton(title: "다음", font: .labelLargeSemiBold)
    
    // MARK: - Init
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Methods
    
    private func setupView() {
        backgroundColor = .white
    }
    
    private func setupLayout() {
        addSubview(label)
        label.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(99)
            make.centerX.equalToSuperview()
        }
        
        addSubview(buttonContainer)
        buttonContainer.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().inset(48)
            make.height.equalTo(50)
        }
        
        [prevButton, nextButton].forEach { buttonContainer.addArrangedSubview($0) }
        
        prevButton.snp.makeConstraints { make in
            make.width.equalToSuperview().dividedBy(3.5)
        }
        
        addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.top.equalTo(label.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalTo(buttonContainer.snp.top).offset(-95)
        }
    }
}
