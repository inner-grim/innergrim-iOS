//
//  OnboardingFirstView.swift
//  FeatureOnboarding
//
//  Created by 지연 on 11/5/24.
//

import UIKit

import Shared
import SnapKit

public final class OnboardingFirstView: UIView {
    // MARK: - Components
    
    private let label = {
        let label = UILabel()
        label.text = "그리미와\n솔직한 대화를 나누고"
        label.applyTypography(with: .titleLarge)
        label.textColor = .labelNormal
        label.numberOfLines = 2
        label.textAlignment = .center
        return label
    }()
    
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
            make.top.equalToSuperview().inset(85)
            make.centerX.equalToSuperview()
        }
        
        addSubview(nextButton)
        nextButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().inset(48)
            make.height.equalTo(50)
        }
    }
}
