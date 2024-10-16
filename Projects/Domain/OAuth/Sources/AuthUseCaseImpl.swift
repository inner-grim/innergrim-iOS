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
        return networkService.request(target, responseType: Response<String>.self)
            .tryMap { response in
                print("statusCode: \(response.statusCode)")
                print("message: \(response.message)")
                print("data: \(response.data)")
            }
            .map { _ in
                return OAuthResult.success(provider)
            }
            .mapError { error in
                guard let networkError = error as? NetworkError else {
                    return OAuthError.unknown(error)
                }
                return OAuthError.networkError(networkError)
            }
            .eraseToAnyPublisher()
    }
}

