//
//  SettingsViewController.swift
//  innergrim
//
//  Created by 지연 on 12/23/24.
//

import Combine
import UIKit

protocol SettingsViewControllerDelegate: AnyObject {
    func moveToLogin()
}

final class SettingsViewController: BaseViewController<SettingsView> {
    weak var delegate: SettingsViewControllerDelegate?
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar(title: "설정", backImage: .dismiss)
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
        
        logoutButton.tapPublisher
            .sink { [weak self] in
                self?.showAlert(
                    title: "로그아웃 하시겠어요?",
                    message: "",
                    leftActionText: "돌아가기",
                    rightActionText: "로그아웃",
                    rightActionCompletion:  {
                        KeychainService.clear()
                        UserDataStorage.isLogin = false
                        self?.delegate?.moveToLogin()
                    }
                )
            }
            .store(in: &cancellables)
    }
}

private extension SettingsViewController {
    var logoutButton: UIButton {
        contentView.logoutButton
    }
}
