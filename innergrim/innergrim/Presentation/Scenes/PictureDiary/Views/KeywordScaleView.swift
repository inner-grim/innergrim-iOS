//
//  KeywordScaleView.swift
//  innergrim
//
//  Created by 지연 on 12/22/24.
//

import UIKit

final class KeywordScaleView: UIView {
    // MARK: - Components
    
    private let imageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .primaryNormal
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 24
        return imageView
    }()
    
    private lazy var keywordLabel = createTitleLabel(with: "키워드")
    
    private lazy var keywordDetailLabel = createDetailLabel("#그리운 #불행한 #아쉬운")
    
    private lazy var scaleLabel = createTitleLabel(with: "척도")
    
    private lazy var scaleDetailLabel = createDetailLabel("5점 (매우 강하게)")
    
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
    
    // MARK: - Setup Methods
    
    private func setupView() {
        layer.cornerRadius = 16
        layer.borderWidth = 1
        layer.borderColor = UIColor.lineNormal.cgColor
    }
    
    private func setupLayout() {
        addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.width.height.equalTo(48)
            make.leading.equalToSuperview().inset(16)
            make.centerY.equalToSuperview()
        }
        
        addSubview(keywordLabel)
        keywordLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(18)
            make.leading.equalTo(imageView.snp.trailing).offset(20)
        }
        
        addSubview(keywordDetailLabel)
        keywordDetailLabel.snp.makeConstraints { make in
            make.leading.equalTo(keywordLabel.snp.trailing).offset(8)
            make.centerY.equalTo(keywordLabel)
        }
        
        addSubview(scaleLabel)
        scaleLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(18)
            make.leading.equalTo(imageView.snp.trailing).offset(20)
        }
        
        addSubview(scaleDetailLabel)
        scaleDetailLabel.snp.makeConstraints { make in
            make.leading.equalTo(keywordDetailLabel)
            make.centerY.equalTo(scaleLabel)
        }
    }
}

private extension KeywordScaleView {
    func createTitleLabel(with title: String) -> UILabel {
        let label = UILabel()
        label.text = title
        label.applyTypography(with: .labelMediumSemiBold)
        label.textColor = .labelNeutral
        return label
    }
    
    func createDetailLabel(_ text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.applyTypography(with: .labelMediumMedium)
        label.textColor = .labelNormal
        return label
    }
}
