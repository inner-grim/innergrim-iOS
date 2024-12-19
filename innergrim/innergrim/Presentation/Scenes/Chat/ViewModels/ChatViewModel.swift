//
//  ChatViewModel.swift
//  innergrim
//
//  Created by 지연 on 12/19/24.
//

import Combine
import Foundation

final class ChatViewModel: ViewModel {
    enum Action {
        case viewDidLoad
        case sendButtonDidTap(String)
    }
    
    struct State {
        var chatMessages = PassthroughSubject<[ChatMessage], Never>()
    }
    
    // MARK: - Properties
    
    var actionSubject = PassthroughSubject<Action, Never>()
    var cancellables = Set<AnyCancellable>()
    var state: State
    
    // MARK: - Init
    
    init() {
        self.state = State()
        setupActionBindings()
    }
    
    private func setupActionBindings() {
        actionSubject.sink { [weak self] action in
            switch action {
            case .viewDidLoad:
                self?.startChat()
            case .sendButtonDidTap(let message):
                self?.sendChat(message)
            }
        }
        .store(in: &cancellables)
    }
    
    private func startChat() {
        state.chatMessages.send([ChatMessage(content: "첫 대화 내용 텍스트", isFromUser: false)])
    }
    
    private func sendChat(_ message: String) {
    }
}
