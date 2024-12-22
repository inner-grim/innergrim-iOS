//
//  CalendarCellViewModel.swift
//  innergrim
//
//  Created by 지연 on 12/22/24.
//

import Foundation

struct CalendarCellViewModel: Hashable {
    let id = UUID()
    let type: CalendarCellType
    let imageURL: String?
    let day: String
}
