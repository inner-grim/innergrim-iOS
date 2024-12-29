//
//  EmotionHeader.swift
//  innergrim
//
//  Created by 지연 on 12/29/24.
//

import UIKit

final class EmotionHeader: UICollectionReusableView, Reusable {
    private let label = {
        let label = UILabel()
        label.textColor = .labelAssistive
        label.textAlignment = .left
        return label
    }()
    
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
        addSubview(label)
        label.snp.makeConstraints { make in
            make.top.leading.equalToSuperview()
        }
    }
    
    // MARK: - Configure Methods
    
    func configure(with viewModel: EmotionSectionViewModel) {
        label.text = viewModel.category.rawValue
        label.applyTypography(with: .labelSmallMedium)
    }
}
