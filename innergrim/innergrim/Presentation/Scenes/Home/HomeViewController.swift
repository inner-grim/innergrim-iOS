//
//  HomeViewController.swift
//  innergrim
//
//  Created by 지연 on 12/19/24.
//

import Combine
import UIKit

protocol HomeViewControllerDelegate: AnyObject {
    func chatViewControllerWillAppear()
}

final class HomeViewController: BaseViewController<HomeView> {
    weak var delegate: HomeViewControllerDelegate?
    private var cancellabels = Set<AnyCancellable>()
    
    // MARK: - Lifeycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
    }

    override func viewSafeAreaInsetsDidChange() {
        super.viewSafeAreaInsetsDidChange()
        configureBottomSafeArea()
    }
    
    // MARK: - Setup Methods
    
    private func setupBindings() {
        // action
        shareTodayButton.tapPublisher
            .sink { [weak self] in
                self?.delegate?.chatViewControllerWillAppear()
            }
            .store(in: &cancellabels)
    }
}

private extension HomeViewController {
    var shareTodayButton: SolidButton {
        contentView.shareTodayButton
    }
}
