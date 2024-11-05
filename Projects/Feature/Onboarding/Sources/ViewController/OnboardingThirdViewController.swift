//
//  OnboardingThirdViewController.swift
//  FeatureOnboarding
//
//  Created by 지연 on 11/5/24.
//

import Combine
import UIKit

import Shared

public protocol OnboardingThirdViewControllerDelegate: AnyObject {
    func onboardingThirdViewControllerDidFinish()
}

public final class OnboardingThirdViewController: BaseViewController<OnboardingThirdView> {
    public weak var delegate: OnboardingThirdViewControllerDelegate?
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Lifecycle
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
    }
    
    // MARK: - Setup Methods
    
    private func setupBindings() {
        prevButton.tapPublisher
            .sink { [weak self] in
                self?.navigationController?.popViewController(animated: true)
            }
            .store(in: &cancellables)
        
        startButton.tapPublisher
            .sink { [weak self] in
                self?.delegate?.onboardingThirdViewControllerDidFinish()
            }
            .store(in: &cancellables)
    }
}

private extension OnboardingThirdViewController {
    var prevButton: AssistiveButton {
        contentView.prevButton
    }
    
    var startButton: SolidButton {
        contentView.startButton
    }
}
