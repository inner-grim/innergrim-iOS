//
//  Interceptor.swift
//  innergrim
//
//  Created by 지연 on 12/19/24.
//

import Foundation

import Alamofire

final class Interceptor: RequestInterceptor {
    func adapt(
        _ urlRequest: URLRequest,
        for session: Session,
        completion: @escaping (Result<URLRequest, any Error>) -> Void
    ) {
        var request = urlRequest
        
        if let deviceID = getDeviceID() {
            request.addValue(deviceID, forHTTPHeaderField: "device-id")
        }
        
        if let accessToken = getAccessToken() {
            request.addValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        }
        
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        completion(.success(request))
    }
    
    private func getDeviceID() -> String? {
        return KeychainService.retrieve(for: .deviceId)
    }
    
    private func getAccessToken() -> String? {
        return KeychainService.retrieve(for: .accessToken)
    }
}
