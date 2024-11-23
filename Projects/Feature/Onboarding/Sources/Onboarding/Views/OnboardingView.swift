//
//  OnboardingView.swift
//  Onboarding
//
//  Created by 지연 on 11/23/24.
//

import UIKit

import Shared

public final class OnboardingView: UIView {
    private var carouselIndicators: [UIView] = []
    
    // MARK: - Components

    let nextButton = SolidButton(title: "다음", font: .labelLargeSemiBold)
    
    let carouselScrollView = {
        let scrollView = UIScrollView()
        scrollView.bounces = false
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()
    
    private let carouselContentView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private let greemiIntroView = OnboardingCardView(
        title: "그리미와\n솔직한 대화를 나누고",
        image: nil
    )
    
    private let greemiPromptView = OnboardingCardView(
        title: "오늘의 하루를\n그려주세요",
        image: nil
    )
    
    private let greemiDiscoveryView = OnboardingCardView(
        title: "나도 몰랐던 내 모습을\n발견할지도 몰라요",
        image: nil
    )
    
    private let carouselIndicatorStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 8.0
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    // MARK: - Init
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
        setupCarouselViews()
        setupCarouselIndicators()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        layoutIfNeeded()
        carouselIndicators.forEach { $0.layer.cornerRadius = $0.frame.height / 2 }
    }
    
    // MARK: - Setup Methods
    
    private func setupLayout() {
        addSubview(nextButton)
        nextButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().inset(28)
            make.height.equalTo(50)
        }
        
        addSubview(carouselScrollView)
        carouselScrollView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(84)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(nextButton.snp.top).offset(-110)
        }
        
        carouselScrollView.addSubview(carouselContentView)
        carouselContentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.height.equalToSuperview()
        }
        
        addSubview(carouselIndicatorStackView)
        carouselIndicatorStackView.snp.makeConstraints { make in
            make.top.equalTo(carouselScrollView.snp.bottom).offset(20)
            make.width.equalTo(46)
            make.height.equalTo(10)
            make.centerX.equalToSuperview()
        }
    }
    
    private func setupCarouselViews() {
        [greemiIntroView, greemiPromptView, greemiDiscoveryView].forEach { view in
            carouselContentView.addArrangedSubview(view)
            view.snp.makeConstraints { make in
                make.width.equalTo(carouselScrollView)
            }
        }
    }
    
    private func setupCarouselIndicators() {
        for _ in carouselContentView.arrangedSubviews {
            let view = UIView()
            carouselIndicatorStackView.addArrangedSubview(view)
            carouselIndicators.append(view)
        }
        // 초기 색상
        updateSelectedIndicator(to: 0)
    }
    
    public func updateSelectedIndicator(to selectedIndex: Int) {
        carouselIndicators.enumerated().forEach { index, view in
            view.backgroundColor = index == selectedIndex ? .primaryNormal : .fillDisabled
        }
    }
}
