//
//  EmotionScaleViewModel.swift
//  innergrim
//
//  Created by 지연 on 1/4/25.
//

import Combine
import Foundation

final class EmotionScaleViewModel: ViewModel {
    enum Action {
        case sliderValueDidChange(value: Int)
        case doneButtonDidTap
    }
    
    struct State {
        var chatStartMessage = PassthroughSubject<String, Never>()
    }
    
    // MARK: - Properties
    
    var actionSubject = PassthroughSubject<Action, Never>()
    var cancellables = Set<AnyCancellable>()
    var state = State()
    
    private let emotionKeywords: [String]
    private var emotionScale = 3
    
    // MARK: - Init
    
    init(emotionKeywords: [String]) {
        self.emotionKeywords = emotionKeywords
        
        actionSubject.sink { [weak self] action in
            self?.handleAction(action)
        }
        .store(in: &cancellables)
    }
    
    // MARK: - Handle Action Methods
    
    private func handleAction(_ action: Action) {
        switch action {
        case .sliderValueDidChange(let value):
            emotionScale = value
        case .doneButtonDidTap:
            prepareChat()
        }
    }
    
    private func prepareChat() {
        var emotionStrings = emotionKeywords
        switch emotionScale {
        case 1:     emotionStrings.append("아주 약하게")
        case 2:     emotionStrings.append("약하게")
        case 3:     emotionStrings.append("보통")
        case 4:     emotionStrings.append("강하게")
        case 5:     emotionStrings.append("아주 강하게")
        default:    break
        }
        let chatStartMessage = emotionStrings.joined(separator: ", ")
        state.chatStartMessage.send(chatStartMessage)
    }
}
