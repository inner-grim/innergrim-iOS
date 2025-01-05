//
//  ValidationTextField.swift
//  innergrim
//
//  Created by 지연 on 12/19/24.
//

import UIKit

final class ValidationTextField: UIView {
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
        view.layer.cornerRadius = 8.0
        view.layer.borderWidth = 1.0
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
    
    // MARK: - Init
    
    init(placeholder: String) {
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
            make.edges.equalToSuperview()
        }
        
        containerView.addSubview(textField)
        textField.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.centerY.equalToSuperview()
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
    
    func updateValidation(_ isValid: Bool) {
        if isValid {
            status = textField.isEditing ? .focus : .normal
        } else {
            status = .error
        }
    }
}
