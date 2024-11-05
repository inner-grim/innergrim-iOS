//
//  AgreementView.swift
//  FeatureOnboarding
//
//  Created by 지연 on 11/6/24.
//

import UIKit

import Shared

public final class AgreementView: UIView {
    // MARK: - Components
    
    let allButton = CheckBoxButton()
    
    private lazy var allLabel = createLabel(
        with: "약관 모두 동의하기",
        font: .titleSmall,
        color: .labelNormal
    )
    
    private let line = {
        let view = UIView()
        view.backgroundColor = .lineNormal
        return view
    }()
    
    let innergrimButton = CheckBoxButton()
    
    lazy var innergrimLabel = createUnderlineLabel(with: "이너그림 이용 약관 동의 (필수)")
    
    let privacyButton = CheckBoxButton()
    
    lazy var privacyLabel = createUnderlineLabel(with: "개인정보 처리 방침 동의 (필수)")
    
    let marketingButton = CheckBoxButton()
    
    lazy var marketingLabel = createUnderlineLabel(with: "마케팅 수신 동의 (선택)")
    
    private lazy var marketingDescriptionLabel = createLabel(
        with: "이너그림에서 제공하는 맞춤형 일기 분석 및 일기 생성 시 시간 알림 등을 앱 푸시와 메일로 전달해 드립니다.",
        font: .labelSmallMedium,
        color: .labelAssistive
    )
    
    let nextButton = SolidButton(title: "다음", font: .labelLargeSemiBold)
    
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
        addSubview(allButton)
        allButton.snp.makeConstraints { make in
            make.width.height.equalTo(34)
            make.top.equalToSuperview().inset(20)
            make.leading.equalToSuperview().inset(16)
        }
        
        addSubview(allLabel)
        allLabel.snp.makeConstraints { make in
            make.leading.equalTo(allButton.snp.trailing).offset(8)
            make.centerY.equalTo(allButton)
        }
        
        addSubview(line)
        line.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.top.equalTo(allButton.snp.bottom).offset(12)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        addSubview(innergrimButton)
        innergrimButton.snp.makeConstraints { make in
            make.width.height.equalTo(34)
            make.top.equalTo(line.snp.bottom).offset(12)
            make.leading.equalToSuperview().inset(16)
        }
        
        addSubview(innergrimLabel)
        innergrimLabel.snp.makeConstraints { make in
            make.leading.equalTo(innergrimButton.snp.trailing).offset(8)
            make.centerY.equalTo(innergrimButton)
        }
        
        addSubview(privacyButton)
        privacyButton.snp.makeConstraints { make in
            make.width.height.equalTo(34)
            make.top.equalTo(innergrimButton.snp.bottom).offset(12)
            make.leading.equalToSuperview().inset(16)
        }
        
        addSubview(privacyLabel)
        privacyLabel.snp.makeConstraints { make in
            make.leading.equalTo(privacyButton.snp.trailing).offset(8)
            make.centerY.equalTo(privacyButton)
        }
        
        addSubview(marketingButton)
        marketingButton.snp.makeConstraints { make in
            make.width.height.equalTo(34)
            make.top.equalTo(privacyButton.snp.bottom).offset(12)
            make.leading.equalToSuperview().inset(16)
        }
        
        addSubview(marketingLabel)
        marketingLabel.snp.makeConstraints { make in
            make.leading.equalTo(marketingButton.snp.trailing).offset(8)
            make.centerY.equalTo(marketingButton)
        }
        
        addSubview(marketingDescriptionLabel)
        marketingDescriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(marketingLabel.snp.bottom).offset(4)
            make.leading.equalTo(marketingLabel)
            make.trailing.equalToSuperview().inset(16)
        }
        
        addSubview(nextButton)
        nextButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().inset(48)
            make.height.equalTo(50)
        }
    }
}

private extension AgreementView {
    func createLabel(with text: String, font: UIFont, color: UIColor) -> UILabel {
        let label = UILabel()
        label.text = text
        label.applyTypography(with: font)
        label.textColor = color
        label.numberOfLines = 0
        return label
    }
    
    func createUnderlineLabel(with text: String) -> UILabel {
        let attributeString = NSMutableAttributedString(string: text)
        attributeString.addAttribute(
            .font,
            value: UIFont.bodyLargeRegular,
            range: NSRange(location: 0, length: text.count)
        )
        attributeString.addAttribute(
            .underlineStyle,
            value: 1,
            range: NSRange(location: 0, length: text.count)
        )
        attributeString.addAttribute(
            .baselineOffset,
            value: 4,
            range: NSRange(location: 0, length: text.count)
        )
        let label = UILabel()
        label.attributedText = attributeString
        label.textColor = .labelNormal
        return label
    }
}
