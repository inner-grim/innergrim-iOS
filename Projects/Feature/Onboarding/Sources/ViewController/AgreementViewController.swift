//
//  AgreementViewController.swift
//  FeatureOnboarding
//
//  Created by 지연 on 11/6/24.
//

import Combine
import UIKit

import Shared

public final class AgreementViewController: BaseViewController<AgreementView> {
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Lifecycle
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar(isDismissButtonHidden: true, title: "약관 동의")
        setupBindings()
    }
    
    // MARK: - Setup Methods
    
    private func setupBindings() {
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
    }
}

private extension AgreementViewController {
    var allButton: CheckBoxButton {
        contentView.allButton
    }
    
    var innergrimButton: CheckBoxButton {
        contentView.innergrimButton
    }
    
    var privacyButton: CheckBoxButton {
        contentView.privacyButton
    }
    
    var marketingButton: CheckBoxButton {
        contentView.marketingButton
    }
    
    var nextButton: SolidButton {
        contentView.nextButton
    }
}
