//
//  PictureDiaryViewController.swift
//  innergrim
//
//  Created by 지연 on 12/22/24.
//

import Combine
import UIKit

final class PictureDiaryViewController: BaseViewController<PictureDiaryView> {
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar(title: "그림일기", backImage: .dismiss) // TODO: 타이틀 변경
        setupBindings()
    }
    
    // MARK: - Setup Methods
    
    private func setupBindings() {
        // action
        backButton.tapPublisher
            .sink { [weak self] in
                self?.dismiss(animated: true)
            }
            .store(in: &cancellables)
    }
}
