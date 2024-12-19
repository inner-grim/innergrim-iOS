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
        
        if let accessToken = getAccessToken() {
            request.addValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        }
        
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        completion(.success(request))
    }
    
    // TODO: 실제 구현이 들어가야 한다.
    private func getAccessToken() -> String? { return nil }
}
