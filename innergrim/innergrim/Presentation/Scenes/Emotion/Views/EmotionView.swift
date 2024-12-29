//
//  EmotionView.swift
//  innergrim
//
//  Created by 지연 on 12/29/24.
//

import UIKit

final class EmotionView: UIView {
    // MARK: - Components
    
    private let scrollView = UIScrollView()
    
    private let contentView = UIView()
    
    private let titleLabel = {
        let label = UILabel()
        label.text = "당장 떠오르는\n감정을 골라볼래?"
        label.applyTypography(with: .titleLarge)
        label.textColor = .labelNormal
        label.numberOfLines = 2
        return label
    }()
    
    private let guideContainer = {
        let view = UIView()
        view.backgroundColor = .fillAssistive
        view.layer.cornerRadius = 8
        return view
    }()
    
    private let checkImageView = {
        let imageView = UIImageView()
        imageView.image = .check
        imageView.tintColor = .labelAssistive
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let guideLabel = {
        let label = UILabel()
        label.text = "최대 3개까지 선택해 주세요."
        label.applyTypography(with: .labelMediumMedium)
        label.textColor = .labelAssistive
        return label
    }()
    
    let collectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.sectionInset = .init(top: 0, left: 0, bottom: 32, right: 0)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.registerCell(cellType: EmotionCell.self)
        collectionView.registerHeader(viewType: EmotionHeader.self)
        collectionView.backgroundColor = .clear
        collectionView.isScrollEnabled = false
        return collectionView
    }()
    
    let doneButton = SolidButton(title: "선택 완료", font: .labelLargeSemiBold)
    
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
        
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().inset(20)
        }
        
        contentView.addSubview(guideContainer)
        guideContainer.snp.makeConstraints { make in
            make.height.equalTo(32)
            make.top.equalTo(titleLabel.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        guideContainer.addSubview(checkImageView)
        checkImageView.snp.makeConstraints { make in
            make.width.height.equalTo(16)
            make.leading.equalToSuperview().inset(8)
            make.centerY.equalToSuperview()
        }
        
        guideContainer.addSubview(guideLabel)
        guideLabel.snp.makeConstraints { make in
            make.leading.equalTo(checkImageView.snp.trailing).offset(4)
            make.centerY.equalToSuperview()
        }
        
        contentView.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.height.equalTo(580)
            make.top.equalTo(guideContainer.snp.bottom).offset(32)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        contentView.addSubview(doneButton)
        doneButton.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.top.equalTo(collectionView.snp.bottom).offset(32)
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().inset(48)
        }
    }
}
