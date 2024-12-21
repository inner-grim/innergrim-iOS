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
    var state = State()
    
    // MARK: - Init
    
    init() {
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
        // 마지막 채팅 날짜 업데이트 및 캐시된 채팅 데이터 초기화
        let today = Date.now
        if !Calendar.current.isDate(UserDataStorage.lastChatDate, inSameDayAs: Date()) {
            UserDataStorage.lastChatDate = today
            UserDataStorage.chatMessages = []
        }
        
        state.chatMessages.send([ChatMessage(content: "첫 대화 내용 텍스트", isFromUser: false)])
    }
    
    private func sendChat(_ message: String) {
        let target = ChatBotAPI.sendChat(message: message)
    }
}
