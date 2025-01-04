//
//  EmotionScaleViewController.swift
//  innergrim
//
//  Created by 지연 on 1/4/25.
//

import Combine
import UIKit

protocol EmotionScaleViewControllerDelegate: AnyObject {
    func chatViewControllerWillAppear()
}

final class EmotionScaleViewController: BottomSheetViewController<EmotionScaleView> {
    weak var delegate: EmotionScaleViewControllerDelegate?
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Init
    
    init() {
        super.init(bottomSheetHeight: 272)
        setupBindings()
    }
    
    // MARK: - Setup Methods
    
    private func setupBindings() {
        // action
        doneButton.tapPublisher
            .sink { [weak self] in
                guard let self = self else { return }
                dismiss(animated: false) {
                    self.delegate?.chatViewControllerWillAppear()
                }
            }
            .store(in: &cancellables)
    }
}

private extension EmotionScaleViewController {
    var doneButton: SolidButton {
        contentView.doneButton
    }
}
