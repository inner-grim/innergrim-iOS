//
//  ChatViewController.swift
//  innergrim
//
//  Created by 지연 on 12/19/24.
//


import Combine
import UIKit

final class ChatViewController: BaseViewController<ChatView> {
    private let viewModel: ChatViewModel
    private var chatDataSource: UITableViewDiffableDataSource<Int, ChatMessage>!
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Init
    
    init(viewModel: ChatViewModel) {
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
        configureNavigationBar(title: "채팅")
        setupChatTableView()
        setupBindings()
        viewModel.send(.viewDidLoad)
    }
    
    // MARK: - Setup Methods
    
    private func setupChatTableView() {
        chatTableView.delegate = self
        
        chatDataSource = UITableViewDiffableDataSource<Int, ChatMessage>(
            tableView: chatTableView
            , cellProvider: { (tableView, indexPath, viewModel) -> UITableViewCell? in
                if viewModel.isFromUser {
                    let cell = tableView.dequeueReusableCell(
                        for: indexPath,
                        cellType: OutgoingMessageCell.self)
                    cell.configure(with: viewModel)
                    return cell
                } else {
                    let cell = tableView.dequeueReusableCell(
                        for: indexPath,
                        cellType: IncomingMessageCell.self)
                    cell.configure(with: viewModel)
                    return cell
                }
            }
        )
    }
    
    private func setupBindings() {
        // action
        dismissButton.tapPublisher
            .sink { [weak self] in
                self?.showAlert(
                    title: "채팅방에서 나가시겠습니까?",
                    message: "대화 내용은 저장되지 않아요!",
                    leftActionText: "대화 계속 하기",
                    rightActionText: "나가기",
                    rightActionCompletion:  { [weak self] in
                        self?.dismiss(animated: true)
                    }
                )
            }
            .store(in: &cancellables)
        
        keyboardWillShowPublisher
            .sink { [weak self] keyboardHeight in
                self?.contentView.updateBottomConstraint(keyboardHeight: keyboardHeight)
            }.store(in: &cancellables)
        
        keyboardWillHidePublisher
            .sink { [weak self] _ in
                self?.contentView.resetBottomConstraint()
            }.store(in: &cancellables)
        
        let tapGesture = UITapGestureRecognizer()
        chatTableView.addGestureRecognizer(tapGesture)
        tapGesture.tapPublisher
            .sink { [weak self] _ in
                self?.view.endEditing(true)
            }.store(in: &cancellables)
        
        messageTextField.textPublisher
            .sink { [weak self] text in
                self?.sendButton.isEnabled = !text.isEmpty
            }
            .store(in: &cancellables)
        
        sendButton.tapPublisher
            .sink { [weak self] in
                guard let self = self, let message = messageTextField.text else { return }
                viewModel.send(.sendButtonDidTap(message))
                messageTextField.text = ""
            }
            .store(in: &cancellables)
        
        // state
        viewModel.state.chatMessages
            .sink { [weak self] chatMessages in
                self?.applySnapshot(with: chatMessages)
            }
            .store(in: &cancellables)
    }
    
    private func applySnapshot(with chatMessages: [ChatMessage]) {
        var snapshot = NSDiffableDataSourceSnapshot<Int, ChatMessage>()
        snapshot.appendSections([0])
        snapshot.appendItems(chatMessages, toSection: 0)
        chatDataSource.apply(snapshot, animatingDifferences: false)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}

extension ChatViewController: UITableViewDelegate {
    func tableView(
        _ tableView: UITableView,
        viewForFooterInSection section: Int
    ) -> UIView? {
        return nil
    }
    
    func tableView(
        _ tableView: UITableView,
        heightForFooterInSection section: Int
    ) -> CGFloat {
        return .leastNonzeroMagnitude
    }
    
    func tableView(
        _ tableView: UITableView,
        viewForHeaderInSection section: Int
    ) -> UIView? {
        return ChatHeaderView()
    }
    
    func tableView(
        _ tableView: UITableView,
        heightForHeaderInSection section: Int
    ) -> CGFloat {
        return 36
    }
}

private extension ChatViewController {
    var chatTableView: UITableView {
        contentView.tableView
    }
    
    var messageTextField: UITextField {
        contentView.messageTextField.textField
    }
    
    var sendButton: UIButton {
        contentView.messageTextField.sendButton
    }
}
