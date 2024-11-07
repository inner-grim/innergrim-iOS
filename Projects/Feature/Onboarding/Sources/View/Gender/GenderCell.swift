//
//  GenderCell.swift
//  FeatureOnboarding
//
//  Created by 지연 on 11/6/24.
//

import UIKit

import Shared

public final class GenderCell: UICollectionViewCell, Reusable {
    public override var isSelected: Bool {
        didSet {
            updateAppearence()
        }
    }
    
    // MARK: - Components
    
    private let stackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 4
        return stackView
    }()
    
    private let typeLabel = {
        let label = UILabel()
        label.textColor = .primaryNormal
        return label
    }()
    
    private let checkImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage.check.withTintColor(.primaryNormal)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    // MARK: - Init
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
        setupLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Methods
    
    private func setupCell() {
        backgroundColor = .primaryLight
        layer.cornerRadius = 8
        layer.borderWidth = 2
        updateAppearence()
    }
    
    private func setupLayout() {
        contentView.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        [checkImageView, typeLabel].forEach { stackView.addArrangedSubview($0) }
        
        checkImageView.snp.makeConstraints { make in
            make.width.height.equalTo(20)
        }
    }
    
    private func updateAppearence() {
        layer.borderColor = (isSelected ? UIColor.primaryNormal : UIColor.primaryLight).cgColor
        checkImageView.isHidden = !isSelected
    }
    
    // MARK: - Configure Methods
    
    public func configure(with type: GenderType) {
        typeLabel.text = type.rawValue
        typeLabel.applyTypography(with: .labelLargeSemiBold)
    }
}
