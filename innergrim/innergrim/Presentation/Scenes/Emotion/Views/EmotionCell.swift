//
//  EmotionCell.swift
//  innergrim
//
//  Created by 지연 on 12/29/24.
//

import UIKit

final class EmotionCell: UICollectionViewCell, Reusable {
    // MARK: - Components
    
    private let emotionLabel = UILabel()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Methods
    
    private func setupCell() {
        layer.cornerRadius = 8
        layer.borderWidth = 1
        layer.borderColor = UIColor.lineNormal.cgColor
    }
    
    private func setupLayout() {
        contentView.addSubview(emotionLabel)
        emotionLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    // MARK: - Configure Methods
    
    func configure(with viewModel: EmotionCellViewModel) {
        emotionLabel.text = viewModel.emotion.rawValue
        emotionLabel.applyTypography(with: .labelLargeMedium)
        backgroundColor = viewModel.isSelected ? .primaryLight : .clear
        layer.borderColor = viewModel.isSelected ?
        UIColor.primaryNormal.cgColor :
        UIColor.lineNormal.cgColor
    }
}
