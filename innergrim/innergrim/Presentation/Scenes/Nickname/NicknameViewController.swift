//
//  NicknameViewController.swift
//  innergrim
//
//  Created by 지연 on 12/19/24.
//

import Combine
import UIKit

protocol NicknameViewControllerDelegate: AnyObject {
    func nicknameViewControllerDidFinish()
}

final class NicknameViewController: BaseViewController<NicknameView> {
    weak var delegate: NicknameViewControllerDelegate?
    private let viewModel: NicknameViewModel
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Init
    
    init(viewModel: NicknameViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBarHidden()
        setupBindings()
    }
    
    // MARK: - Setup Methods
    
    private func setupBindings() {
        // action
        nicknameTextField.textField.textPublisher
            .dropFirst()
            .sink { [weak self] text in
                self?.viewModel.send(.nicknameDidUpdate(text))
            }
            .store(in: &cancellables)
        
        nextButton.tapPublisher
            .sink { [weak self] in
                self?.nicknameTextField.textField.resignFirstResponder()
                self?.nextButton.isUserInteractionEnabled = false
                self?.viewModel.send(.nextButtonDidTap)
            }
            .store(in: &cancellables)
        
        keyboardWillShowPublisher
            .sink { [weak self] keyboardHeight in
                self?.contentView.updateNextButtonBottomConstraint(keyboardHeight: keyboardHeight)
            }
            .store(in: &cancellables)
        
        keyboardWillHidePublisher
            .sink { [weak self] _ in
                self?.contentView.resetNextButtonBottomConstraint()
            }
            .store(in: &cancellables)
        
        // state
        viewModel.state.isNicknameValid
            .receive(on: RunLoop.main)
            .dropFirst()
            .sink { [weak self] isValid in
                self?.nicknameTextField.updateValidation(isValid)
                self?.nextButton.isEnabled = isValid
            }
            .store(in: &cancellables)
        
        viewModel.state.result
            .receive(on: RunLoop.main)
            .sink { [weak self] result in
                self?.nextButton.isUserInteractionEnabled = true
                if result {
                    self?.delegate?.nicknameViewControllerDidFinish()
                }
            }
            .store(in: &cancellables)
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
