//
//  AgreementViewController.swift
//  Onboarding
//
//  Created by 지연 on 11/23/24.
//

import Combine
import UIKit

import FeatureOnboardingInterface
import Shared

public final class AgreementViewController: BaseViewController<AgreementView> {
    public weak var delegate: AgreementViewControllerDelegate?
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Lifecycle
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar(isDismissButtonHidden: true, title: "약관 동의", actionImage: .bell)
        setupBindings()
    }
    
    // MARK: - Setup Methods
    
    private func setupBindings() {
        // action
        allButton.tapPublisher
            .sink { [weak self] in
                self?.allButton.isSelected.toggle()
            }
            .store(in: &cancellables)
        
        innergrimButton.tapPublisher
            .sink { [weak self] in
                self?.innergrimButton.isSelected.toggle()
            }
            .store(in: &cancellables)
        
        privacyButton.tapPublisher
            .sink { [weak self] in
                self?.privacyButton.isSelected.toggle()
            }
            .store(in: &cancellables)
        
        marketingButton.tapPublisher
            .sink { [weak self] in
                self?.marketingButton.isSelected.toggle()
            }
            .store(in: &cancellables)
        
        nextButton.tapPublisher
            .sink { [weak self] in
                self?.delegate?.agreementViewControllerDidFinish()
            }
            .store(in: &cancellables)
    }
}

private extension AgreementViewController {
    var allButton: CheckButton {
        contentView.allButton
    }
    
    var innergrimButton: CheckButton {
        contentView.innergrimButton
    }
    
    var privacyButton: CheckButton {
        contentView.privacyButton
    }
    
    var marketingButton: CheckButton {
        contentView.marketingButton
    }
    
    var nextButton: SolidButton {
        contentView.nextButton
    }
}
