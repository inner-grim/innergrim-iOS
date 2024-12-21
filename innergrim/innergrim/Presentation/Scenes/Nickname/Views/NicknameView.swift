//
//  NicknameView.swift
//  innergrim
//
//  Created by 지연 on 12/19/24.
//

import UIKit

import SnapKit

final class NicknameView: UIView {
    private var nextButtonBottomConstraint: Constraint?
    
    // MARK: - Components
    
    private let progressBar = ProgressBar(progress: .first)
    
    private let imageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .fillAssistive
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let titleLabel = {
        let label = UILabel()
        label.text = "반가워!\n너의 이름은 뭐야?"
        label.applyTypography(with: .titleLarge)
        label.textColor = .labelNormal
        label.numberOfLines = 2
        label.textAlignment = .center
        return label
    }()
    
    let textField = ValidationTextField(placeholder: "닉네임을 입력해주세요")
    
    let nextButton = SolidButton(initialEnabled: false, title: "다음", font: .labelLargeSemiBold)
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.layer.cornerRadius = imageView.frame.width / 2
    }
    
    // MARK: - Setup Methods
    
    private func setupLayout() {
        addSubview(progressBar)
        progressBar.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(20)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(6)
        }
        
        addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.width.height.equalTo(48)
            make.top.equalTo(progressBar.snp.bottom).offset(42)
            make.centerX.equalToSuperview()
        }
        
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }
        
        addSubview(textField)
        textField.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        addSubview(nextButton)
        nextButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            nextButtonBottomConstraint = make.bottom.equalToSuperview().inset(48).constraint
            make.height.equalTo(50)
        }
    }
    
    func updateNextButtonBottomConstraint(keyboardHeight: CGFloat) {
        nextButtonBottomConstraint?.update(offset: -20 - keyboardHeight)
        layoutIfNeeded()
    }
    
    func resetNextButtonBottomConstraint() {
        nextButtonBottomConstraint?.update(offset: -48)
        layoutIfNeeded()
    }
}
