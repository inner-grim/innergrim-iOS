//
//  Task.swift
//  Network
//
//  Created by 지연 on 11/24/24.
//

import Foundation

public enum Task {
    case requestPlain
    case requestParameters(parameters: [String: Any], encoding: ParameterEncoding)
}
