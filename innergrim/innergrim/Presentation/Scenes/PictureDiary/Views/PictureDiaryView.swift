//
//  PictureDiaryView.swift
//  innergrim
//
//  Created by 지연 on 12/22/24.
//

import UIKit

final class PictureDiaryView: UIView {
    // MARK: - Components
    
    private let scrollView = UIScrollView()
    
    private let contentView = UIView()
    
    private let keywordScaleView = KeywordScaleView()
    
    private let containerView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.layoutMargins = UIEdgeInsets(top: 24, left: 24, bottom: 24, right: 24)
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layer.cornerRadius = 16
        stackView.layer.borderWidth = 1
        stackView.layer.borderColor = UIColor.lineNormal.cgColor
        return stackView
    }()
    
    private let pictureImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .primaryLight
        return imageView
    }()
    
    private let diaryLabel = {
        let label = UILabel()
        label.text = "그림일기 요약 텍스트가 올 자리입니다. 그림일기 요약 텍스트가 올 자리입니다. 그림일기 요약 텍스트가 올 자리입니다. 그림일기 요약 텍스트가 올 자리입니다. 그림일기 요약 텍스트가 올 자리입니다. 그림일기 요약 텍스트가 올 자리입니다. 그림일기 요약 텍스트가 올 자리입니다. 그림일기 요약 텍스트가 올 자리입니다. 그림일기 요약 텍스트가 올 자리입니다. 그림일기 요약 텍스트가 올 자리입니다. 그림일기 요약 텍스트가 올 자리입니다."
        label.applyTypography(with: .labelDiary)
        label.numberOfLines = 0
        return label
    }()
    
    let moveToHomeButton = SolidButton(title: "홈으로 이동하기", font: .labelLargeSemiBold)
    
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
        addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        scrollView.addSubview(contentView)
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
            make.height.greaterThanOrEqualToSuperview()
        }
        
        contentView.addSubview(keywordScaleView)
        keywordScaleView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(20)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(80)
        }
        
        contentView.addSubview(moveToHomeButton)
        moveToHomeButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(48)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(50)
        }
        
        contentView.addSubview(containerView)
        containerView.snp.makeConstraints { make in
            make.top.equalTo(keywordScaleView.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalTo(moveToHomeButton.snp.top).offset(-20)
        }
        
        [pictureImageView, diaryLabel].forEach { containerView.addArrangedSubview($0) }
        
        pictureImageView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(24)
            make.height.equalTo(pictureImageView.snp.width) // 정사각형 비율 유지
        }
    }
}
