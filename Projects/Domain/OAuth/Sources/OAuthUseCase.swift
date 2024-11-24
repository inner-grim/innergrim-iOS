//
//  OAuthUseCaseImpl.swift
//  OAuth
//
//  Created by 지연 on 11/24/24.
//

import AuthenticationServices
import Combine
import Foundation

import Core
import DomainOAuthInterface
import KakaoSDKCommon

public final class OAuthUseCase: OAuthLoginUseCaseProtocol {
    private let loginServices: [OAuthLoginServiceProtocol]
    private let networkService: NetworkServiceProtocol
    private let keychainService: KeychainServiceProtocol
    
    public init(
        loginServices: [OAuthLoginServiceProtocol],
        networkService: NetworkServiceProtocol,
        keychainService: KeychainServiceProtocol
    ) {
        self.loginServices = loginServices
        self.networkService = networkService
        self.keychainService = keychainService
    }
    
    public func login(with provider: OAuthProvider) -> AnyPublisher<OAuthResult, OAuthError> {
        guard let service = loginServices.first(where: { $0.provider == provider }) else {
            return Fail(error: .unsupportedProvider).eraseToAnyPublisher()
        }
        
        return service.login()
            .flatMap { socialId in
                self.verifyUser(provider: provider, id: socialId)
                    .catch { error -> AnyPublisher<OAuthResult, OAuthError> in
                        switch error {
                        case .userNotFound:
                            print("👩🏻‍💻 회원 아님")
                            return self.registerUser(provider: provider, id: socialId)
                        default:
                            print("👩🏻‍💻 에러 발생")
                            return Fail(error: error).eraseToAnyPublisher()
                        }
                    }
            }
            .eraseToAnyPublisher()
    }
    
    private func verifyUser(
        provider: OAuthProvider,
        id: String
    ) -> AnyPublisher<OAuthResult, OAuthError> {
        let target = AuthAPI.postAuthMemberLogin(socialType: provider.rawValue, socialId: id)
        return networkService.request(target, responseType: PostAuthMemeberLoginResponse.self)
            .tryMap { response in
                guard let tokenData = response.data else {
                    throw OAuthError.userNotFound
                }
                print("👩🏻‍💻 로그인 완료")
                try self.saveTokens(
                    accessToken: tokenData.accessToken,
                    refreshToken: tokenData.refreshToken
                )
                return OAuthResult.success((provider, id))
            }
            .mapError { self.mapError($0) }
            .eraseToAnyPublisher()
    }
    
    private func saveTokens(accessToken: String, refreshToken: String) throws {
        do {
            try keychainService.save(accessToken, for: .accessToken)
            try keychainService.save(refreshToken, for: .refreshToken)
        } catch {
            throw OAuthError.tokenSaveFailed
        }
    }
    
    private func registerUser(
        provider: OAuthProvider,
        id: String
    ) -> AnyPublisher<OAuthResult, OAuthError> {
        print("👩🏻‍💻 회원가입")
        let target = MemberAPI.postMember(socialType: provider.rawValue, socialId: id)
        return networkService.request(target, responseType: PostMemberResponse.self)
            .mapError { self.mapError($0) }
            .flatMap { _ in self.verifyUser(provider: provider, id: id) }
            .eraseToAnyPublisher()
    }
    
    private func mapError(_ error: Error) -> OAuthError {
        if let oauthError = error as? OAuthError {
            return oauthError
        }
        if let networkError = error as? NetworkError {
            switch networkError {
            case .serverError(let statusCode) where statusCode == 404:
                return .userNotFound
            case .serverError(let statusCode) where statusCode == 401:
                return .unauthorized
            default:
                return .networkError(networkError)
            }
        }
        return .unknown(error)
    }
}
