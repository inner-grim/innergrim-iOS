//
//  CalendarView.swift
//  innergrim
//
//  Created by 지연 on 12/22/24.
//

import UIKit

final class CalendarView: UIView {
    // MARK: - Components
    
    private let stackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    let collectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(cellType: CalendarCell.self)
        collectionView.backgroundColor = .clear
        return collectionView
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
        addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(20)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        [createLabel(with: "일"),
         createLabel(with: "월"),
         createLabel(with: "화"),
         createLabel(with: "수"),
         createLabel(with: "목"),
         createLabel(with: "금"),
         createLabel(with: "토")].forEach {
            stackView.addArrangedSubview($0)
        }
        
        addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(stackView.snp.bottom).offset(20)
            make.bottom.equalToSuperview().inset(20)
            make.leading.trailing.equalToSuperview().inset(16)
        }
    }
}

private extension CalendarView {
    func createLabel(with text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.applyTypography(with: .bodyLargeRegular)
        label.textColor = .labelAssistive
        label.textAlignment = .center
        return label
    }
}
