//
//  EmotionKeywordSectionViewModel.swift
//  innergrim
//
//  Created by 지연 on 12/29/24.
//

import Foundation

struct EmotionKeywordSectionViewModel: Hashable {
    let category: EmotionKeyword.Category
    var cellViewModels: [EmotionKeywordCellViewModel]
}
