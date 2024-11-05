//
//  ChatViewController.swift
//  FeatureHome
//
//  Created by 지연 on 11/6/24.
//

import Combine
import UIKit

import Shared

public final class ChatViewController: BaseViewController<ChatView> {
    private var cancellables = Set<AnyCancellable>()
    
    private let incomingMessages = [
        IncomingMessage(message: "안녕 반가워! 난 그리미야.\n오늘 하루는 어땠어?"),
        IncomingMessage(message: "오늘 하루 행복한 기분을 느꼈구나!"),
        IncomingMessage(message: "그렇구나. 이 기분이 너에게 얼마나 크게 다가오고 있어?"),
        IncomingMessage(message: "행복하다고 답해줘서 나도 기뻐! 어떤 일이 있었는지 얘기해줄래?"),
        IncomingMessage(message: "요리하는 재미를 발견했구나! 도전해보고 싶은 요리나 추천하는 레시피가 있을까?")
    ]
    
    // MARK: - Lifecycle
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar(title: "채팅")
        setupChatTableView()
        setupBindings()
    }
    
    // MARK: - Setup Methods
    
    private func setupChatTableView() {
        chatTableView.delegate = self
        chatTableView.dataSource = self
    }
    
    private func setupBindings() {
        keyboardWillShowPublisher
            .sink { [weak self] keyboardHeight in
                self?.contentView.updateBottomConstraint(keyboardHeight: keyboardHeight)
            }.store(in: &cancellables)
        
        keyboardWillHidePublisher
            .sink { [weak self] _ in
                self?.contentView.resetBottomConstraint()
            }.store(in: &cancellables)
    }
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}

extension ChatViewController: UITableViewDelegate {
    public func tableView(
        _ tableView: UITableView,
        viewForFooterInSection section: Int
    ) -> UIView? {
        return ChatHeaderView()
    }
    
    public func tableView(
        _ tableView: UITableView,
        heightForFooterInSection section: Int
    ) -> CGFloat {
        return 36
    }
    
    public func tableView(
        _ tableView: UITableView,
        viewForHeaderInSection section: Int
    ) -> UIView? {
        return nil
    }
    
    public func tableView(
        _ tableView: UITableView,
        heightForHeaderInSection section: Int
    ) -> CGFloat {
        return .leastNonzeroMagnitude
    }
}

extension ChatViewController: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return incomingMessages.count
    }
    
    public func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: IncomingMessageCell.self)
        cell.configure(with: incomingMessages.reversed()[indexPath.row])
        return cell
    }
}

private extension ChatViewController {
    var chatTableView: UITableView {
        contentView.tableView
    }
    
    var messageTextField: MessageTextField {
        contentView.messageTextField
    }
}
