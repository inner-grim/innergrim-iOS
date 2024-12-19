//
//  KeychainService.swift
//  innergrim
//
//  Created by 지연 on 12/19/24.
//

import Foundation

final class KeychainService {
    // MARK: - Singleton
    
    static let shared = KeychainService()
    private init() {}
    
    // MARK: - CRUD Methods
    
    func save(_ value: String, for key: KeychainKey) -> Bool {
        guard let data = value.data(using: .utf8) else {
            return false
        }
        
        delete(for: key)
        
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key.rawValue,
            kSecValueData as String: data
        ]
        
        let status = SecItemAdd(query as CFDictionary, nil)
        
        return status == noErr
    }
    
    func retrieve(for key: KeychainKey) -> String? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key.rawValue,
            kSecReturnData as String: true,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]
        
        var result: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &result)
        
        guard status == noErr,
              let data = result as? Data,
              let string = String(data: data, encoding: .utf8) else {
            return nil
        }
        
        return string
    }
    
    @discardableResult
    func delete(for key: KeychainKey) -> Bool {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key.rawValue
        ]
        
        let status = SecItemDelete(query as CFDictionary)
        
        return status == noErr
    }
    
    func clear() -> Bool {
        let query: [String: Any] = [kSecClass as String: kSecClassGenericPassword]
        
        let status = SecItemDelete(query as CFDictionary)
        
        return status == noErr
    }
}
