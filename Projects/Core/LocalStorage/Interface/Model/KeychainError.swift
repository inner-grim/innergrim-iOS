//
//  KeychainError.swift
//  LocalStorage
//
//  Created by 지연 on 11/24/24.
//

import Foundation

public enum KeychainError: Error {
    case stringConversionFailed
    case itemNotFound
    case unexpectedStatus(OSStatus)
}
