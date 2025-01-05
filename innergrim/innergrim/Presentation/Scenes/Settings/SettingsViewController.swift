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
    private let viewModel: SettingsViewModel
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Init
    
    init(viewModel: SettingsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
                guard let self = self else { return }
                generateHaptic()
                dismiss(animated: true)
            }
            .store(in: &cancellables)
        
        logoutButton.tapPublisher
            .sink { [weak self] in
                guard let self = self else { return }
                generateHaptic()
                showAlert(
                    title: "로그아웃 하시겠어요?",
                    message: "",
                    leftActionText: "돌아가기",
                    rightActionText: "로그아웃",
                    rightActionCompletion:  {
                        self.viewModel.send(.logout)
                    }
                )
            }
            .store(in: &cancellables)
        
        withdrawButton.tapPublisher
            .sink { [weak self] in
                guard let self = self else { return }
                generateHaptic()
                showAlert(
                    title: "정말 회원탈퇴 하시겠어요?",
                    message: "탈퇴할 경우, 데이터 복구가 불가능합니다.\n다시 한번 확인해 주세요.",
                    leftActionText: "돌아가기",
                    rightActionText: "회원 탈퇴",
                    rightActionCompletion:  {
                        self.viewModel.send(.withdraw)
                    }
                )
            }
            .store(in: &cancellables)
        
        // state
        viewModel.state.moveToLogin
            .sink { [weak self] in
                self?.delegate?.moveToLogin()
            }
            .store(in: &cancellables)
    }
}

private extension SettingsViewController {
    var logoutButton: UIButton {
        contentView.logoutButton
    }
    
    var withdrawButton: UIButton {
        contentView.withdrawtButton
    }
}
