//
//  CheckBoxButton.swift
//  SharedDesignSystem
//
//  Created by 지연 on 11/6/24.
//

import UIKit

public final class CheckBoxButton: UIButton {
    private let defaultImage = SharedDesignSystemAsset.Images.checkBoxDefault.image
    private let pressedImage = SharedDesignSystemAsset.Images.checkBoxPressed.image
    private let selectedImage = SharedDesignSystemAsset.Images.checkBoxSelected.image
    
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
