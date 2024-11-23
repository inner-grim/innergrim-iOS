//
//  CheckButton.swift
//  Onboarding
//
//  Created by 지연 on 11/23/24.
//

import UIKit

import Shared

public final class CheckButton: UIButton {
    public override var isHighlighted: Bool {
        didSet {
            updateButtonState()
        }
    }
    
    public override var isSelected: Bool {
        didSet {
            updateButtonState()
        }
    }
    
    // MARK: - Init
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Methods
    
    private func setupButton() {
        layer.cornerRadius = 4.0
        layer.borderWidth = 2.0
        // 이미지
        setImage(.check.withTintColor(.white), for: .normal)
        setImage(.check.withTintColor(.white), for: .highlighted)
        setImage(.check.withTintColor(.white), for: .selected)
        // 초기 상태
        updateButtonState()
    }
    
    private func updateButtonState() {
        if isHighlighted {
            applyHighlightedState()
        } else if isSelected {
            applySelectedState()
        } else {
            applyNormalState()
        }
    }
    
    private func applyNormalState() {
        backgroundColor = .clear
        layer.borderColor = UIColor.lineStrong.cgColor
    }
    
    private func applyHighlightedState() {
        backgroundColor = .primaryStrong
        layer.borderColor = UIColor.primaryStrong.cgColor
    }
    
    private func applySelectedState() {
        backgroundColor = .primaryNormal
        layer.borderColor = UIColor.primaryNormal.cgColor
    }
    
    // MARK: - Layout
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        updateButtonState()
    }
}
