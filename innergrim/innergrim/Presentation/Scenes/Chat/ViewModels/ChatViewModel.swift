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
        var chatMessages = CurrentValueSubject<[ChatMessage], Never>([])
    }
    
    // MARK: - Properties
    
    var actionSubject = PassthroughSubject<Action, Never>()
    var cancellables = Set<AnyCancellable>()
    var state = State()
    
    private let chatStartMessage: String
    
    // MARK: - Init
    
    init(chatStartMessage: String) {
        self.chatStartMessage = chatStartMessage
        actionSubject.sink { [weak self] action in
            self?.handleAction(action)
        }
        .store(in: &cancellables)
    }
    
    // MARK: - Handle Action Methods
    
    private func handleAction(_ action: Action) {
        switch action {
        case .viewDidLoad:
            startChat()
        case .sendButtonDidTap(let message):
            appendChatMessage(message, chatMessageState: .user)
            sendChat(message)
        }
    }
    
    private func startChat() {
        // 마지막 채팅 날짜 업데이트 및 캐시된 채팅 데이터 초기화
        let today = Date.now
        if !Calendar.current.isDate(UserDataStorage.lastChatDate, inSameDayAs: Date()) {
            UserDataStorage.lastChatDate = today
            UserDataStorage.chatMessages = [
                ChatMessage(content: chatStartMessage, state: .user)
            ]
        }
        sendChat(chatStartMessage)
    }
    
    private func appendChatMessage(_ message: String, chatMessageState: ChatMessageState) {
        let newMessage = ChatMessage(content: message, state: chatMessageState)
        // 뷰에 사용할 데이터 반영
        var chatMessages = state.chatMessages.value
        chatMessages.append(newMessage)
        state.chatMessages.send(chatMessages)
        // 로컬 스토리지 반영
        UserDataStorage.chatMessages.append(newMessage)
    }
    
    private func sendChat(_ message: String) {
        let target = ChatBotAPI.sendChat(
            previousConversionList: UserDataStorage.chatMessages.map { $0.toEntity() },
            question: message
        )
        APIService.request(target, responseType: ChatResponse.self)
            .sink { completion in
                if case let .failure(error) = completion {
                    print("Chat failed", error.localizedDescription)
                }
            } receiveValue: { [weak self] response in
                guard let self = self else { return }
                
                if response.statusCode == "OK",
                   let message = response.data?.parsedResponse {
                    appendChatMessage(message, chatMessageState: .assistant)
                } else {
                    print("채팅 응답 에러", response.message) // TODO: 에러 처리 필요
                }
            }
            .store(in: &cancellables)
    }
}
