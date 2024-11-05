//
//  ValidationTextField.swift
//  FeatureOnboarding
//
//  Created by 지연 on 11/6/24.
//

import UIKit

import Shared

public final class ValidationTextField: UIView {
    private let normalBorderColor = UIColor.lineNormal.cgColor
    private let focusBorderColor = UIColor.lineStrong.cgColor
    private let errorBorderColor = UIColor.systemRed.cgColor
    
    private enum ValidationTextFieldStatus {
        case normal
        case focus
        case error
    }
    
    private var status: ValidationTextFieldStatus = .normal {
        didSet {
            setupBorderColor()
        }
    }
    // MARK: - Components
    
    private lazy var containerView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 8
        view.layer.borderWidth = 1
        view.layer.borderColor = normalBorderColor
        return view
    }()
    
    let textField = {
        let textField = UITextField()
        textField.font = .bodyLargeRegular
        textField.textColor = .labelNormal
        textField.clearButtonMode = .always
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        return textField
    }()
    
    private let messageLabel = {
        let label = UILabel()
        label.applyTypography(with: .labelSmallMedium)
        return label
    }()
    
    // MARK: - Init
    
    public init(placeholder: String) {
        super.init(frame: .zero)
        setupTextField(with: placeholder)
        setupLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Methods
    
    private func setupTextField(with placeholder: String) {
        textField.placeholder = placeholder
        textField.addTarget(self, action: #selector(editingDidBegin), for: .editingDidBegin)
        textField.addTarget(self, action: #selector(editingDidEnd), for: .editingDidEnd)
    }
    
    private func setupLayout() {
        addSubview(containerView)
        containerView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(52)
        }
        
        containerView.addSubview(textField)
        textField.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.centerY.equalToSuperview()
        }
        
        addSubview(messageLabel)
        messageLabel.snp.makeConstraints { make in
            make.top.equalTo(containerView.snp.bottom).offset(8)
            make.leading.bottom.equalToSuperview()
        }
    }
    
    private func setupBorderColor() {
        switch status {
        case .normal:   containerView.layer.borderColor = normalBorderColor
        case .focus:    containerView.layer.borderColor = focusBorderColor
        case .error:    containerView.layer.borderColor = errorBorderColor
        }
    }
    
    // MARK: - Action Methods
    
    @objc private func editingDidBegin() {
        status = .focus
    }
    
    @objc private func editingDidEnd() {
        status = .normal
    }
    
    // MARK: - Configure Methods
    
    public func updateValidation(isValid: Bool, message: String?) {
        if isValid {
            status = textField.isEditing ? .focus : .normal
            messageLabel.textColor = .labelNeutral
        } else {
            status = .error
            messageLabel.textColor = .systemRed
        }
        messageLabel.text = message
        messageLabel.isHidden = message == nil
    }
}
