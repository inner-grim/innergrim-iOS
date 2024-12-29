//
//  Emotion.swift
//  innergrim
//
//  Created by 지연 on 12/29/24.
//

import Foundation

enum Emotion: String, CaseIterable {
    case touched = "감동적이야"
    case grateful = "감사해"
    case goodMood = "기분 좋아"
    case satisfied = "만족해"
    case glad = "반가워"
    case proud = "뿌듯해"
    case pound = "설레"
    case excited = "신나"
    case joyful = "즐거워"
    case comfortable = "편안해"
    case happy = "행복해"
    case relieved = "후련해"
    case thrilled = "짜릿해"
    case fun = "재밌어"
    
    case agonized = "괴로워"
    case disappointed = "실망스러워"
    case frustrated = "답답해"
    case lonely = "외로워"
    case vexed = "짜증나"
    case angry = "화나"
    case sorry = "죄송해"
    case sad = "슬퍼"
    case depressed = "우울해"
    case worried = "걱정돼"
    case anxious = "불안해"
    case uncomfortable = "불편해"
    case tired = "지쳤어"
    case upset = "속상해"
    
    case soSo = "그냥 그래"
    case mixedFeelings = "시원 섭섭해"
    case bored = "심심해"
    case awkward = "어색해"
    case flustered = "당황스러워"
    case surprised = "놀랐어"
    case embarrassed = "민망해"
    case concerned = "고민돼"
    case nervous = "긴장돼"
    case eager = "간절해"
    case annoyed = "귀찮아"
}

extension Emotion {
    enum Category: String {
        case positive = "긍정"
        case negative = "부정"
        case neutral = "중립"
    }
    
    var category: Category {
        switch self {
        case .touched, .grateful, .goodMood, .satisfied, .glad, .proud, .pound, .excited, .joyful,
                .comfortable, .happy, .relieved, .thrilled, .fun:
            return .positive
        case .agonized, .disappointed, .frustrated, .lonely, .vexed, .angry, .sorry, .sad,
                .depressed, .worried, .anxious, .uncomfortable, .tired, .upset:
            return .negative
        case .soSo, .mixedFeelings, .bored, .awkward, .flustered, .surprised, .embarrassed,
                .concerned, .nervous, .eager, .annoyed:
            return .neutral
        }
    }
}
