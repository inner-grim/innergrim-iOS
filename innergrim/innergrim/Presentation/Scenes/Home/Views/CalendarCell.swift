//
//  CalendarCell.swift
//  innergrim
//
//  Created by 지연 on 12/22/24.
//

import UIKit

final class CalendarCell: UICollectionViewCell, Reusable {
    // MARK: - Components
    
    private let imageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 20
        return imageView
    }()
    
    private let dayLabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .labelAssistive
        return label
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
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
        backgroundColor = .clear
    }
    
    private func setupLayout() {
        contentView.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.width.height.equalTo(40)
            make.top.leading.trailing.equalToSuperview()
        }
        
        contentView.addSubview(dayLabel)
        dayLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(2)
            make.leading.bottom.trailing.equalToSuperview()
        }
    }
    
    // MARK: - Configure Methods
    
    func configure(with viewModel: CalendarCellViewModel) {
        dayLabel.text = viewModel.day
        dayLabel.applyTypography(with: .labelSmallMedium)
        
        switch viewModel.type {
        case .noDiary:
            imageView.backgroundColor = .fillNormal
        case .diaryWritten:
            imageView.backgroundColor = .primaryNormal
        case .today:
            imageView.backgroundColor = .primaryLight
        default:
            break
        }
    }
}
