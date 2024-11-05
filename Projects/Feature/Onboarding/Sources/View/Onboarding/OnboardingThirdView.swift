//
//  OnboardingThirdView.swift
//  FeatureOnboarding
//
//  Created by 지연 on 11/5/24.
//

import UIKit

import Shared
import SnapKit

public final class OnboardingThirdView: UIView {
    // MARK: - Components
    
    private let label = {
        let label = UILabel()
        label.text = "나도 몰랐던 내 모습을\n발견할지도 몰라요"
        label.applyTypography(with: .titleLarge)
        label.textColor = .labelNormal
        label.numberOfLines = 2
        label.textAlignment = .center
        return label
    }()
    
    private let buttonContainer = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 8
        return stackView
    }()
    
    let prevButton = AssistiveButton(title: "뒤로", font: .labelLargeSemiBold)
    
    let startButton = SolidButton(title: "시작하기", font: .labelLargeSemiBold)
    
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
        
        addSubview(buttonContainer)
        buttonContainer.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).offset(-48)
            make.height.equalTo(50)
        }
        
        [prevButton, startButton].forEach { buttonContainer.addArrangedSubview($0) }
        
        prevButton.snp.makeConstraints { make in
            make.width.equalToSuperview().dividedBy(3.5)
        }
    }
}
