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
        var onboardingResult = PassthroughSubject<Bool, Never>()
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
                self?.checkNicknameDuplicated()
            }
        }
        .store(in: &cancellables)
    }
    
    private func verifyNickname(_ nickname: String) {
        self.nickname = nickname
        
        let pattern = "^[가-힣ㄱ-ㅎㅏ-ㅣa-zA-Z0-9]{1,20}$"
        let regex = try? NSRegularExpression(pattern: pattern)
        let range = NSRange(location: 0, length: nickname.utf16.count)
        
        let isValid = regex?.firstMatch(in: nickname, options: [], range: range) != nil
        state.isNicknameValid.send(isValid)
    }
    
    private func checkNicknameDuplicated() {
        guard let nickname = nickname else { return }
        
        let target = MemberAPI.checkNicknameDuplicated(nickname: nickname)
        APIService.request(target, responseType: CheckNicknameResponse.self)
            .sink { completion in
                if case let .failure(error) = completion {
                    print("Check Nickname failed:", error)
                }
            } receiveValue: { [weak self] response in
                if response.statusCode == "OK",
                   let result = response.data {
                    if result { // 닉네임 중복
                        Toaster.makeToast("이미 사용중인 닉네임이에요")
                    } else { // 사용 가능한 닉네임
                        self?.sendOnboardingInfo()
                    }
                } else {
                    self?.state.onboardingResult.send(false)
                }
            }
            .store(in: &cancellables)
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
                
                state.onboardingResult.send(response.statusCode == "OK")
            }
            .store(in: &cancellables)
    }
}
