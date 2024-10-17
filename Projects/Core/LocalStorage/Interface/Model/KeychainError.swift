//
//  KeychainError.swift
//  CoreLocalStorageInterface
//
//  Created by 지연 on 10/17/24.
//

import Foundation

public enum KeychainError: Error {
    case stringConversionFailed
    case itemNotFound
    case unexpectedStatus(OSStatus)
}
