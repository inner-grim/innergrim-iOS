//
//  KeyChainStorage.swift
//  CoreLocalStorageInterface
//
//  Created by 지연 on 10/17/24.
//

import Foundation

public protocol KeyChainStorage {
    func save(_ value: String, for key: KeychainKey) throws
    func retrieve(for key: KeychainKey) throws -> String
    func delete(for key: KeychainKey) throws
}
