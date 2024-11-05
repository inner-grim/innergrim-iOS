//
//  OnboardingFirstViewController.swift
//  FeatureOnboarding
//
//  Created by 지연 on 11/5/24.
//

import Combine
import UIKit

import Shared

public protocol OnboardingFirstViewControllerDelegate: AnyObject {
    func onboardingFirstViewControllerDidFinish()
}

public final class OnboardingFirstViewController: BaseViewController<OnboardingFirstView> {
    public weak var delegate: OnboardingFirstViewControllerDelegate?
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Lifecycle
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
    }
    
    // MARK: - Setup Methods
    
    private func setupBindings() {
        nextButton.tapPublisher
            .sink { [weak self] in
                self?.delegate?.onboardingFirstViewControllerDidFinish()
            }
            .store(in: &cancellables)
    }
}

private extension OnboardingFirstViewController {
    var nextButton: SolidButton {
        contentView.nextButton
    }
}
