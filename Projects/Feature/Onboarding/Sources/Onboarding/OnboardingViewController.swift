//
//  OnboardingViewController.swift
//  Onboarding
//
//  Created by 지연 on 11/23/24.
//

import Combine
import UIKit

import FeatureOnboardingInterface
import Shared

public final class OnboardingViewController: BaseViewController<OnboardingView> {
    public weak var delegate: OnboardingViewControllerDelegate?
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Lifecycle
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBarHidden()
        setupCarouselScrollView()
        setupBindings()
    }
    
    // MARK: - Setup Methods
    
    private func setupCarouselScrollView() {
        carouselScrollView.delegate = self
    }
    
    private func setupBindings() {
        // action
        nextButton.tapPublisher
            .sink { [weak self] in
                self?.delegate?.onboardingViewControllerDidFinish()
            }
            .store(in: &cancellables)
    }
}

private extension OnboardingViewController {
    var nextButton: SolidButton {
        contentView.nextButton
    }
    
    var carouselScrollView: UIScrollView {
        contentView.carouselScrollView
    }
}


extension OnboardingViewController: UIScrollViewDelegate {
    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let index = Int(scrollView.contentOffset.x / scrollView.bounds.width)
        // TODO: ViewModel에 selectedIndex 상태 두기 -> nextButton 활성화 여부
        contentView.updateSelectedIndicator(to: index)
    }
}
