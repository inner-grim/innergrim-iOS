//
//  AuthUseCaseImpl.swift
//  DomainAuth
//
//  Created by 지연 on 10/15/24.
//

import AuthenticationServices
import Combine
import Foundation

import Core
import DomainOAuthInterface
import KakaoSDKCommon

public final class OAuthUseCaseImpl: OAuthLoginUseCase {
    private let loginServices: [OAuthLoginService]
    private let networkService: NetworkService
    
    public init(loginServices: [OAuthLoginService], networkService: NetworkService) {
        self.loginServices = loginServices
        self.networkService = networkService
    }
    
    public func login(with provider: OAuthProvider) -> AnyPublisher<OAuthResult, OAuthError> {
        guard let service = loginServices.first(where: { $0.provider == provider }) else {
            return Fail(error: .unsupportedProvider).eraseToAnyPublisher()
        }
        return service.login()
            .map { (provider, $0) }
            .flatMap(verifyUser)
            .eraseToAnyPublisher()
    }
    
    private func verifyUser(
        provider: OAuthProvider,
        id: String
    ) -> AnyPublisher<OAuthResult, OAuthError> {
        let target = MemberAPI.postMember(socialType: provider.rawValue, socialId: id)
        return networkService.request(target, responseType: PostMemberResponse.self)
            .map { _ in OAuthResult.success((provider, id)) }
            .mapError { OAuthError.networkError($0) }
            .eraseToAnyPublisher()
    }
}

