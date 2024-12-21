//
//  NicknameViewModel.swift
//  innergrim
//
//  Created by 지연 on 12/22/24.
//

import Combine
import Foundation

final class NicknameViewModel: NSObject, ViewModel {
    enum Action {
        case nicknameDidUpdate(String)
        case nextButtonDidTap
    }
    
    struct State {
        var isNicknameValid = CurrentValueSubject<Bool, Never>(true)
        var result = PassthroughSubject<Bool, Never>()
    }
    
    // MARK: - Properties
    
    var actionSubject = PassthroughSubject<Action, Never>()
    var cancellables = Set<AnyCancellable>()
    var state = State()
    
    private var nickname: String?
    
    // MARK: - Init
    
    override init() {
        super.init()
        setupActionBindings()
    }
    
    private func setupActionBindings() {
        actionSubject.sink { [weak self] action in
            switch action {
            case .nicknameDidUpdate(let nickname):
                self?.verifyNickname(nickname)
            case .nextButtonDidTap:
                self?.sendOnboardingInfo()
            }
        }
        .store(in: &cancellables)
    }
    
    private func verifyNickname(_ nickname: String) {
        self.nickname = nickname
        
        let pattern = "^[가-힣ㄱ-ㅎㅏ-ㅣa-zA-Z0-9]{1,10}$"
        let regex = try? NSRegularExpression(pattern: pattern)
        let range = NSRange(location: 0, length: nickname.utf16.count)
        
        let isValid = regex?.firstMatch(in: nickname, options: [], range: range) != nil
        state.isNicknameValid.send(isValid)
    }
    
    private func sendOnboardingInfo() {
        guard let nickname = nickname else { return }
        
        let target = MemberAPI.onboarding(nickname: nickname)
        APIService.request(target, responseType: CommonResponse.self)
            .sink { completion in
                if case let .failure(error) = completion {
                    print("Onboarding failed:", error)
                }
            } receiveValue: { [weak self] response in
                guard let self = self else { return }
                
                state.result.send(response.statusCode == "OK")
            }
            .store(in: &cancellables)
        
        state.result.send(true)
    }
}
