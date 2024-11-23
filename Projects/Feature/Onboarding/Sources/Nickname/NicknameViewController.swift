//
//  NicknameViewController.swift
//  Onboarding
//
//  Created by 지연 on 11/23/24.
//

import Combine
import UIKit

import FeatureOnboardingInterface
import Shared

public final class NicknameViewController: BaseViewController<NicknameView> {
    public weak var delegate: NicknameViewControllerDelegate?
    private var cancellabels = Set<AnyCancellable>()
    
    // MARK: - Lifecycle
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBarHidden()
        setupBindings()
    }
    
    // MARK: - Setup Methods
    
    private func setupBindings() {
        // action
        nextButton.tapPublisher
            .sink { [weak self] in
                self?.delegate?.nicknameViewControllerDidFinish()
            }
            .store(in: &cancellabels)
    }
}

private extension NicknameViewController {
    var nicknameTextField: ValidationTextField {
        contentView.textField
    }
    
    var nextButton: SolidButton {
        contentView.nextButton
    }
}
