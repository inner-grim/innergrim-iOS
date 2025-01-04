//
//  EmotionScaleViewController.swift
//  innergrim
//
//  Created by 지연 on 1/4/25.
//

import Combine
import UIKit

protocol EmotionScaleViewControllerDelegate: AnyObject {
    func navigateToChatViewController()
}

final class EmotionScaleViewController: BottomSheetViewController<EmotionScaleView> {
    weak var delegate: EmotionScaleViewControllerDelegate?
    private let viewModel: EmotionScaleViewModel
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Init
    
    init(viewModel: EmotionScaleViewModel) {
        self.viewModel = viewModel
        super.init(bottomSheetHeight: 272)
        setupBindings()
    }
    
    // MARK: - Setup Methods
    
    private func setupBindings() {
        // action
        slider.valuePublisher
            .sink { [weak self] value in
                self?.viewModel.send(.sliderValueDidChange(value: Int(value)))
            }
            .store(in: &cancellables)
        
        doneButton.tapPublisher
            .sink { [weak self] in
                guard let self = self else { return }
                dismiss(animated: false) {
                    self.viewModel.send(.doneButtonDidTap)
                }
            }
            .store(in: &cancellables)
        
        // state
        viewModel.state.chatStartMessage
            .sink { [weak self] message in
                print(message)
            }
            .store(in: &cancellables)
    }
}

private extension EmotionScaleViewController {
    var slider: UISlider {
        contentView.slider
    }
    
    var doneButton: SolidButton {
        contentView.doneButton
    }
}
