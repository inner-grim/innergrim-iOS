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
        stackView.alignment = .center
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
        label.text = "오늘은 아침에 일어나자마자 날씨가 맑아서 기분이 좋았다. 회사에 가는 길에 카페에 들러 아이스 아메리카노를 한 잔 샀다. 점심으로 동료들과 함께 맛있는 파스타를 먹었다. 퇴근 후에는 집 근처 공원을 산책하며 하루를 정리하는 시간을 가졌다. 이렇게 평온한 하루를 보낼 수 있어서 감사한 마음이 든다."
//        label.text = "오늘은 아침에 일어나자마자 날씨가 맑아서 기분이 좋았다."
        label.applyTypography(with: .labelDiary)
        label.numberOfLines = 0
        return label
    }()
    
    let shareButton = SolidButton(title: "공유하기", font: .bodyLargeSemiBold)
    
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
        
        contentView.addSubview(shareButton)
        shareButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(50)
            make.bottom.equalToSuperview().inset(48)
        }
        
        contentView.addSubview(containerView)
        containerView.snp.makeConstraints { make in
            make.top.equalTo(keywordScaleView.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.lessThanOrEqualTo(shareButton.snp.top).offset(-20)
        }
        
        [pictureImageView, diaryLabel].forEach { containerView.addArrangedSubview($0) }
        
        pictureImageView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(24)
            make.height.equalTo(pictureImageView.snp.width) // 정사각형 비율 유지
        }
    }
}
