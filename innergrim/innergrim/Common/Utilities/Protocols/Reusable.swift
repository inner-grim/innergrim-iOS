//
//  Reusable.swift
//  innergrim
//
//  Created by 지연 on 12/19/24.
//

import Foundation

protocol Reusable: AnyObject {
    static var reuseIdentifier: String { get }
}

extension Reusable {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
