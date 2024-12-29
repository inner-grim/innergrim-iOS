//
//  EmotionSectionViewModel.swift
//  innergrim
//
//  Created by 지연 on 12/29/24.
//

import Foundation

struct EmotionSectionViewModel: Hashable {
    let category: Emotion.Category
    var cellViewModels: [EmotionCellViewModel]
}
