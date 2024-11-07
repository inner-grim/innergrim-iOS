//
//  CheckBoxButton.swift
//  SharedDesignSystem
//
//  Created by 지연 on 11/6/24.
//

import UIKit

public final class CheckBoxButton: UIButton {
    private let defaultImage = UIImage.checkBoxDefault
    private let pressedImage = UIImage.checkBoxPressed
    private let selectedImage = UIImage.checkBoxSelected
    
    // MARK: - Init
    
    public init() {
        super.init(frame: .zero)
        setupButton()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Methods
    
    private func setupButton() {
        backgroundColor = .clear
        setBackgroundImage(pressedImage, for: .highlighted)
        setBackgroundImage(defaultImage, for: .normal)
        setBackgroundImage(selectedImage, for: .selected)
    }
}
