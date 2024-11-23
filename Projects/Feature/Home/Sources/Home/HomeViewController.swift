//
//  HomeViewController.swift
//  Home
//
//  Created by 지연 on 11/23/24.
//

import Combine
import UIKit

import FeatureHomeInterface
import Shared

public final class HomeViewController: BaseViewController<HomeView> {
    public weak var delegate: HomeViewControllerDelegate?
    private var cancellabels = Set<AnyCancellable>()
    
    // MARK: - Lifeycle
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
    }

    public override func viewSafeAreaInsetsDidChange() {
        super.viewSafeAreaInsetsDidChange()
        configureBottomSafeArea()
    }
    
    // MARK: - Setup Methods
    
    private func setupBindings() {
        // action
        shareTodayButton.tapPublisher
            .sink { [weak self] in
                self?.delegate?.homeViewControllerDidRequestChat()
            }
            .store(in: &cancellabels)
    }
}

private extension HomeViewController {
    var shareTodayButton: SolidButton {
        contentView.shareTodayButton
    }
}
