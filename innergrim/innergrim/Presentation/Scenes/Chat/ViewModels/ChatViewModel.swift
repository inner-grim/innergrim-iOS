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
        
        appendChatMessage("첫 대화 내용 텍스트", isFromUser: false)
    }
    
    private func sendChat(_ message: String) {
        appendChatMessage(message, isFromUser: true)
        
        let target = ChatBotAPI.sendChat(message: message)
        APIService.request(target, responseType: ChatResponse.self)
            .sink { completion in
                if case let .failure(error) = completion {
                    print("Chat failed", error.localizedDescription)
                }
            } receiveValue: { [weak self] response in
                guard let self = self else { return }
                
                if response.statusCode == "OK",
                   let message = response.data?.parsedResponse {
                    appendChatMessage(message, isFromUser: false)
                } else {
                    print("채팅 응답 에러", response.message) // TODO: 에러 처리 필요
                }
            }
            .store(in: &cancellables)
    }
    
    private func appendChatMessage(_ message: String, isFromUser: Bool) {
        let newMessage = ChatMessage(content: message, isFromUser: isFromUser)
        // 뷰에 사용할 데이터 반영
        var chatMessages = state.chatMessages.value
        chatMessages.append(newMessage)
        state.chatMessages.send(chatMessages)
        // 로컬 스토리지 반영
        UserDataStorage.chatMessages.append(newMessage)
    }
}
