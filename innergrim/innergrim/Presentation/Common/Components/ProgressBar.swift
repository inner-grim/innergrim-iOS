//
//  ProgressBar.swift
//  innergrim
//
//  Created by 지연 on 12/19/24.
//

import UIKit

final class ProgressBar: UIView {
    enum Progress: Int, CaseIterable {
        case first = 1
        case second = 2
    }
    
    // MARK: - Components
    
    private let progressView = {
        let view = UIView()
        view.backgroundColor = .primaryNormal
        return view
    }()
    
    // MARK: - Init
    
    init(progress: Progress) {
        super.init(frame: .zero)
        setupView()
        setupLayout(with: progress)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let radius = frame.height / 2
        layer.cornerRadius = radius
        progressView.layer.cornerRadius = radius
    }
    
    // MARK: - Setup Methods
    
    private func setupView() {
        backgroundColor = .primaryLight
    }
    
    private func setupLayout(with progress: Progress) {
        let widthRatio = Double(progress.rawValue) / Double(Progress.allCases.count)
        
        addSubview(progressView)
        progressView.snp.makeConstraints { make in
            make.top.leading.bottom.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(widthRatio)
        }
    }
}
