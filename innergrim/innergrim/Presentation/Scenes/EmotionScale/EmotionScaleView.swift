//
//  EmotionScaleView.swift
//  innergrim
//
//  Created by 지연 on 1/4/25.
//

import UIKit

final class EmotionScaleView: UIView {
    // MARK: - Components
    
    private let titleLabel = {
        let label = UILabel()
        label.text = "이 감정이 너에게 얼마나 영향을 주고 있어?"
        label.applyTypography(with: .titleSmall)
        label.textColor = .labelNormal
        return label
    }()
    
    private let sliderImageView = {
        let imageView = UIImageView()
        imageView.image = .slider
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let sliderThumb = {
        let image = UIImage.apple
        return image
    }()
    
    lazy var slider = {
        let slider = UISlider()
        slider.minimumValue = 1
        slider.maximumValue = 5
        slider.thumbTintColor = .primaryNormal
        slider.minimumTrackTintColor = .clear
        slider.maximumTrackTintColor = .clear
        slider.setThumbImage(makeSliderThumbImage(), for: .normal)
        slider.setThumbImage(makeSliderThumbImage(), for: .highlighted)
        slider.addTarget(self, action: #selector(sliderValueChanged), for: .valueChanged)
        slider.value = 3
        return slider
    }()
    
    private let scaleLabelStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    let doneButton = SolidButton(title: "확인", font: .labelLargeSemiBold)
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Methods
    
    private func setupLayout() {
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(36)
            make.centerX.equalToSuperview()
        }
        
        addSubview(sliderImageView)
        sliderImageView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(24)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(40)
        }
        
        addSubview(slider)
        slider.snp.makeConstraints { make in
            make.edges.equalTo(sliderImageView)
        }
        
        addSubview(scaleLabelStackView)
        scaleLabelStackView.snp.makeConstraints { make in
            make.top.equalTo(sliderImageView.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        [makeScaleLabel(with: "매우 약하게", alignment: .left),
         makeScaleLabel(with: "보통", alignment: .center),
         makeScaleLabel(with: "매우 강하게", alignment: .right)].forEach {
            scaleLabelStackView.addArrangedSubview($0)
        }
        
        addSubview(doneButton)
        doneButton.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().inset(48)
        }
    }
    
    // MARK: - Action Methods
    
    @objc private func sliderValueChanged(_ sender: UISlider) {
        let roundedValue = round(sender.value)
        sender.value = roundedValue
    }
}

private extension EmotionScaleView {
    func makeScaleLabel(with text: String, alignment: NSTextAlignment) -> UILabel {
        let label = UILabel()
        label.text = text
        label.applyTypography(with: .labelSmallMedium)
        label.textColor = .labelAssistive
        label.textAlignment = alignment
        return label
    }
    
    func makeSliderThumbImage() -> UIImage {
        let image = UIImage.sliderThumb
        let size = CGSize(width: 40, height: 40)
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        image.draw(in: CGRect(origin: .zero, size: size))
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return resizedImage!
    }
}
