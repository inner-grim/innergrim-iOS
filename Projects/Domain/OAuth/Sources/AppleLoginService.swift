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
    private var subject: PassthroughSubject<String, OAuthError> = .init()
    
    public override init() {}
    
    public func login() -> AnyPublisher<String, OAuthError> {
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        
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
            subject.send(completion: .failure(.unknown(NSError(domain: "unexpected error", code: 0))))
            return
        }
        
        subject.send(appleIDCredential.user)
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
                subject.send(completion: .failure(.appleError(error)))
            }
        } else {
            subject.send(completion: .failure(.unknown(NSError(domain: "unexpected error", code: 0))))
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
