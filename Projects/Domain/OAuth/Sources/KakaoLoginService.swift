//
//  KakaoLoginService.swift
//  DomainAuth
//
//  Created by 지연 on 10/15/24.
//

import Combine
import Foundation

import DomainOAuthInterface
import KakaoSDKAuth
import KakaoSDKCommon
import KakaoSDKUser

public final class KakaoLoginService: OAuthLoginService {
    public let provider: OAuthProvider = .kakao
    private var subject: PassthroughSubject<UserEntity, OAuthError> = .init()
    
    public init() {}
    
    public func login() -> AnyPublisher<UserEntity, OAuthError> {
        if UserApi.isKakaoTalkLoginAvailable() {
            UserApi.shared.loginWithKakaoTalk { [weak self] (oauthToken, error) in
                self?.handleLoginResult(oauthToken: oauthToken, error: error)
            }
        } else {
            UserApi.shared.loginWithKakaoAccount { [weak self] (oauthToken, error) in
                self?.handleLoginResult(oauthToken: oauthToken, error: error)
            }
        }
        
        return subject.eraseToAnyPublisher()
    }
    
    private func handleLoginResult(oauthToken: OAuthToken?, error: Error?) {
        if let error = error {
            let oauthError = mapToOAuthError(error)
            subject.send(completion: .failure(oauthError))
        } else if oauthToken != nil {
            getUserInfo()
        } else {
            subject.send(completion: .failure(.unknown))
        }
    }
    
    private func getUserInfo() {
        UserApi.shared.me() { [weak self] (user, error) in
            guard let self = self else {
                // self가 없는 경우 subject에 에러를 보내고 종료
                let subject = PassthroughSubject<UserEntity, OAuthError>()
                subject.send(completion: .failure(.unknown))
                return
            }
            
            if let error = error {
                let oauthError = self.mapToOAuthError(error)
                self.subject.send(completion: .failure(oauthError))
            } else if let socialID = user?.id {
                let user = UserEntity(
                    id: String(socialID),
                    provider: .kakao
                )
                
                self.subject.send(user)
                self.subject.send(completion: .finished)
            } else {
                self.subject.send(completion: .failure(.invalidResponse))
            }
        }
    }
}

private extension KakaoLoginService {
    func mapToOAuthError(_ error: Error) -> OAuthError {
        if let sdkError = error as? SdkError {
            switch sdkError {
            case .ClientFailed:
                return .clientError
            case .ApiFailed:
                return .serverError
            case .AuthFailed:
                return .authenticationFailed
            default:
                return .unknown
            }
        } else {
            return .unknown
        }
    }
}
