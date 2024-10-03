//
//  Task.swift
//  CoreNetwork
//
//  Created by 지연 on 9/24/24.
//

import Foundation

public enum Task {
    case requestPlain
    case requestParameters(parameters: [String: Any], encoding: ParameterEncoding)
}
