//
//  MessageTextField.swift
//  innergrim
//
//  Created by 지연 on 12/19/24.
//

import UIKit

final class MessageTextField: UIView {
    private let disabledColor = UIColor.fillDisabled
    private let enabledColor = UIColor.primaryNormal
    private let pressedColor = UIColor.primaryStrong
    
    // MARK: - Components
    
    private let containerView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    let textField = {
        let textField = UITextField()
        textField.placeholder = "메시지 입력"
        textField.font = .bodyLargeRegular
        textField.textColor = .labelNormal
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        return textField
    }()
    
    lazy var sendButton = {
        let button = UIButton()
        button.setBackgroundImage(image(with: disabledColor), for: .disabled)
        button.setBackgroundImage(image(with: enabledColor), for: .normal)
        button.setBackgroundImage(image(with: pressedColor), for: .highlighted)
        button.setImage(UIImage.arrowUp.withTintColor(.white), for: .normal)
        button.setImage(UIImage.arrowUp.withTintColor(.white), for: .highlighted)
        button.imageEdgeInsets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        button.clipsToBounds = true
        return button
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layoutIfNeeded()
        containerView.layer.cornerRadius = containerView.frame.height / 2
        sendButton.layer.cornerRadius = sendButton.frame.width / 2
    }
    
    // MARK: - Setup Methods
    
    private func setupView() {
        backgroundColor = .fillAssistive
    }
    
    private func setupLayout() {
        addSubview(containerView)
        containerView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(12)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(52)
        }
        
        containerView.addSubview(sendButton)
        sendButton.snp.makeConstraints { make in
            make.width.height.equalTo(36)
            make.trailing.equalToSuperview().inset(12)
            make.centerY.equalToSuperview()
        }
        
        containerView.addSubview(textField)
        textField.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(20)
            make.trailing.equalTo(sendButton.snp.leading).offset(-4)
            make.centerY.equalToSuperview()
        }
    }
}
