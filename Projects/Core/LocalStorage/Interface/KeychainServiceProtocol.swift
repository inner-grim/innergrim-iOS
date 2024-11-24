//
//  KeychainServiceProtocol.swift
//  LocalStorage
//
//  Created by 지연 on 11/24/24.
//
import Foundation

public protocol KeychainServiceProtocol {
    func save(_ value: String, for key: KeychainKey) throws
    func retrieve(for key: KeychainKey) throws -> String
    func delete(for key: KeychainKey) throws
}
