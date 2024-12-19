//
//  NicknameViewController.swift
//  innergrim
//
//  Created by 지연 on 12/19/24.
//

import Combine
import UIKit

final class NicknameViewController: BaseViewController<NicknameView> {
    private var cancellabels = Set<AnyCancellable>()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBarHidden()
        setupBindings()
    }
    
    // MARK: - Setup Methods
    
    private func setupBindings() {
        // action
        nextButton.tapPublisher
            .sink { [weak self] in
            }
            .store(in: &cancellabels)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
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
