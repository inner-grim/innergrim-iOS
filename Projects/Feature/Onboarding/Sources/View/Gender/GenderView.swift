//
//  GenderView.swift
//  FeatureOnboarding
//
//  Created by 지연 on 11/6/24.
//

import UIKit

import Shared

public final class GenderView: UIView {
    // MARK: - Components
    
    private let progressBar = ProgressBar(progress: .second)
    
    private let imageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .gray400
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let titleLabel = {
        let label = UILabel()
        label.text = "해당하는\n성별을 선택해줘!"
        label.applyTypography(with: .titleLarge)
        label.textColor = .labelNormal
        label.numberOfLines = 2
        label.textAlignment = .center
        return label
    }()
    
    private let descriptionLabel = {
        let label = UILabel()
        label.text = "가입 완료 후 변경이 어려우니 신중하게 선택해 주세요."
        label.applyTypography(with: .labelSmallMedium)
        label.textColor = .labelAssistive
        return label
    }()
    
    let collectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 8
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(cellType: GenderCell.self)
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    let startButton = SolidButton(title: "시작하기", font: .labelLargeSemiBold)
    
    // MARK: - Init
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        imageView.layer.cornerRadius = imageView.frame.width / 2
    }
    
    // MARK: - Setup Methods
    
    private func setupLayout() {
        addSubview(progressBar)
        progressBar.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(20)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(6)
        }
        
        addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.width.height.equalTo(48)
            make.top.equalTo(progressBar.snp.bottom).offset(42)
            make.centerX.equalToSuperview()
        }
        
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }
        
        addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }
        
        addSubview(startButton)
        startButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).offset(-48)
            make.height.equalTo(50)
        }
        
        addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalTo(startButton.snp.top)
        }
    }
}
