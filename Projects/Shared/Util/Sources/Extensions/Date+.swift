//
//  Date+.swift
//  SharedUtil
//
//  Created by 지연 on 11/23/24.
//

import Foundation

extension Date {
    public func formatAsTime() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko_KR")
        dateFormatter.dateFormat = "a HH:mm"
        return dateFormatter.string(from: self)
    }
}
