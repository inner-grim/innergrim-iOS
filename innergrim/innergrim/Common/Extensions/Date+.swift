//
//  Date+.swift
//  innergrim
//
//  Created by 지연 on 12/19/24.
//

import Foundation

extension Date {
    func formatAsTime() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko_KR")
        dateFormatter.dateFormat = "a HH:mm"
        return dateFormatter.string(from: self)
    }
}
