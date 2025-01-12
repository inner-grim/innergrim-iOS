//
//  Encodable+.swift
//  innergrim
//
//  Created by 지연 on 1/5/25.
//

import Foundation

extension Encodable {
    var dictionary: [String: Any]? {
        guard let data = try? JSONEncoder().encode(self),
              let jsonObject = try? JSONSerialization.jsonObject(with: data),
              let dictionary = jsonObject as? [String: Any] else {
            return nil
        }
        return dictionary
    }
}
