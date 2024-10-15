//
//  AppleLoginService.swift
//  DomainAuth
//
//  Created by 지연 on 10/15/24.
//

import AuthenticationServices
import Combine
import Foundation

import DomainOAuthInterface

public final class AppleLoginService: NSObject, OAuthLoginService {
    public let provider: OAuthProvider = .apple
    private var subject: PassthroughSubject<UserEntity, OAuthError> = .init()
    
    public override init() {}
    
    public func login() -> AnyPublisher<UserEntity, OAuthError> {
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
        
        return subject.eraseToAnyPublisher()
    }
}

extension AppleLoginService: ASAuthorizationControllerDelegate {
    public func authorizationController(
        controller: ASAuthorizationController,
        didCompleteWithAuthorization authorization: ASAuthorization
    ) {
        guard let appleIDCredential = authorization.credential
                as? ASAuthorizationAppleIDCredential else {
            subject.send(completion: .failure(.unknown))
            return
        }
        
        let userIdentifier = appleIDCredential.user
        let fullName = appleIDCredential.fullName
        let email = appleIDCredential.email
        
        let name = [fullName?.familyName, fullName?.givenName]
            .compactMap { $0 }
            .joined()
        
        let user = UserEntity(
            id: userIdentifier,
            name: name,
            email: email,
            provider: .apple
        )
        
        subject.send(user)
        subject.send(completion: .finished)
    }
    
    public func authorizationController(
        controller: ASAuthorizationController,
        didCompleteWithError error: Error
    ) {
        if let error = error as? ASAuthorizationError {
            switch error.code {
            case .canceled:
                break
            default:
                subject.send(completion: .failure(.unknown))
            }
        } else {
            subject.send(completion: .failure(.unknown))
        }
    }
}

extension AppleLoginService: ASAuthorizationControllerPresentationContextProviding {
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
