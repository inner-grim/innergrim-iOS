//
//  LoginViewModel.swift
//  innergrim
//
//  Created by 지연 on 12/19/24.
//

import AuthenticationServices
import Combine
import Foundation

import KakaoSDKAuth
import KakaoSDKCommon
import KakaoSDKUser

final class LoginViewModel: NSObject, ViewModel {
    enum Action {
        case loginButtonDidTap(SocialType)
    }
    
    struct State {
        var loginResult = PassthroughSubject<Bool, Never>()
    }
    
    // MARK: - Properties
    
    var actionSubject = PassthroughSubject<Action, Never>()
    var cancellables = Set<AnyCancellable>()
    var state = State()
    
    private var provider: SocialType?
    
    // MARK: - Init
    
    override init() {
        super.init()
        setupActionBindings()
    }
    
    private func setupActionBindings() {
        actionSubject.sink { [weak self] action in
            switch action {
            case .loginButtonDidTap(let provider):
                self?.login(for: provider)
            }
        }
        .store(in: &cancellables)
    }
    
    private func login(for provider: SocialType) {
        self.provider = provider
        switch provider {
        case .apple:
            executeAppleLogin()
        case .google:
//            executeGoogleLogin()
            state.loginResult.send(false)
        case .kakao:
            executeKakaoLogin()
        }
    }
    
    private func verifyUser(_ socialId: String) {
        guard let provider = provider else { return }
        
        let target = AuthAPI.login(socialType: provider.rawValue, socialId: socialId)
        APIService.request(target, responseType: LoginResponse.self)
            .sink { [weak self] completion in
                if case let .failure(error) = completion {
                    print("Login failed:", error.localizedDescription)
                    self?.state.loginResult.send(false)
                }
            } receiveValue: { [weak self] response in
                guard let self = self else { return }
                
                if response.statusCode == "OK" {
                    guard let tokenData = response.data else { return }
                    // 로그인 데이터 저장
                    KeychainService.save(tokenData.accessToken, for: .accessToken)
                    KeychainService.save(tokenData.refreshToken, for: .refreshToken)
                    let deviceId = UIDevice.current.identifierForVendor!.uuidString
                    KeychainService.save(deviceId, for: .deviceId)
                    // 성공 결과 전달
                    state.loginResult.send(true)
                } else if response.statusCode == "NOT_FOUND" {
                    // 회원가입
                    signUp(socialId)
                } else {
                    state.loginResult.send(false)
                }
            }
            .store(in: &cancellables)
    }
    
    private func signUp(_ socialId: String) {
        guard let provider = provider else { return }
        
        let target = MemberAPI.signUp(socialType: provider.rawValue, socialId: socialId)
        APIService.request(target, responseType: CommonResponse.self)
            .sink { [weak self] completion in
                if case let .failure(error) = completion {
                    print("Login failed: \(error)")
                    self?.state.loginResult.send(false)
                }
            } receiveValue: { [weak self] response in
                guard let self = self else { return }
                
                if response.statusCode == "OK" {
                    verifyUser(socialId)
                } else {
                    print("Login failed")
                    state.loginResult.send(false)
                }
            }
            .store(in: &cancellables)
    }
}

// MARK: - Apple Login

extension LoginViewModel:
    ASAuthorizationControllerDelegate,
    ASAuthorizationControllerPresentationContextProviding
{
    func executeAppleLogin() {
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }
    
    public func authorizationController(
        controller: ASAuthorizationController,
        didCompleteWithAuthorization authorization: ASAuthorization
    ) {
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            verifyUser(appleIDCredential.user)
        } else {
            state.loginResult.send(false)
        }
    }
    
    public func authorizationController(
        controller: ASAuthorizationController,
        didCompleteWithError error: Error
    ) {
        // 사용자가 로그인을 취소한 경우에는 알림창 띄우지 않음
        if let error = error as? ASAuthorizationError, error.code == .canceled {
            return
        } else {
            state.loginResult.send(false)
        }
    }
    
    public func presentationAnchor(
        for controller: ASAuthorizationController
    ) -> ASPresentationAnchor {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = windowScene.windows.first(where: { $0.isKeyWindow}) else {
            return UIWindow()
        }
        return window
    }
}

// MARK: - Kakao Login

extension LoginViewModel {
    private func executeKakaoLogin() {
        if UserApi.isKakaoTalkLoginAvailable() {
            UserApi.shared.loginWithKakaoTalk { [weak self] (oauthToken, error) in
                self?.handleKakaoLoginResult(oauthToken: oauthToken, error: error)
            }
        } else {
            UserApi.shared.loginWithKakaoAccount { [weak self] (oauthToken, error) in
                self?.handleKakaoLoginResult(oauthToken: oauthToken, error: error)
            }
        }
    }
    
    private func handleKakaoLoginResult(oauthToken: OAuthToken?, error: Error?) {
        if oauthToken != nil {
            getUserInfo()
        } else {
            state.loginResult.send(false)
        }
    }
    
    private func getUserInfo() {
        UserApi.shared.me() { [weak self] (user, error) in
            guard let self = self else { return }
            
            if let socialId = user?.id {
                verifyUser(String(socialId))
            } else {
                state.loginResult.send(false)
            }
        }
    }
}

// MARK: - Google Login

extension LoginViewModel {
    private func executeGoogleLogin() {
        
    }
}
