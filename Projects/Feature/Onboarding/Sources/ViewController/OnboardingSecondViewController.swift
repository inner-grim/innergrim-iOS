//
//  OnboardingSecondViewController.swift
//  FeatureOnboarding
//
//  Created by 지연 on 11/5/24.
//

import Combine
import UIKit

import Shared

public protocol OnboardingSecondViewControllerDelegate: AnyObject {
    func onboardingSecondViewControllerDidFinish()
}

public final class OnboardingSecondViewController: UIViewController {
    public weak var delegate: OnboardingSecondViewControllerDelegate?
    private let onboardingSecondView = OnboardingSecondView()
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Lifecycle
    
    public override func loadView() {
        self.view = onboardingSecondView
    }
    
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
        
        nextButton.tapPublisher
            .sink { [weak self] in
                self?.delegate?.onboardingSecondViewControllerDidFinish()
            }
            .store(in: &cancellables)
    }
}

private extension OnboardingSecondViewController {
    var prevButton: AssistiveButton {
        onboardingSecondView.prevButton
    }
    
    var nextButton: SolidButton {
        onboardingSecondView.nextButton
    }
}
