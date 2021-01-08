//
//  HomeNewQuestionData.swift
//  BeMe
//
//  Created by Yunjae Kim on 2021/01/06.
//

import Foundation


// MARK: - DataClass
struct HomeNewQuestionData: Codable {
    let id: Int?
    let answerIdx: Int?
    let content: String?
    let publicFlag: Int?
    let commentBlockedFlag: Bool?
    let createdAt: String?
    let answerDate: String?
    let questionID: Int?
    let questionTitle: String?
    let questionCategoryID: Int?
    let questionCategoryName: String?
    let isToday: Bool?

    enum CodingKeys: String, CodingKey {
        case id
        case answerIdx = "answer_idx"
        case content
        case publicFlag = "public_flag"
        case commentBlockedFlag = "comment_blocked_flag"
        case createdAt = "created_at"
        case answerDate = "answer_date"
        case questionID = "Question.id"
        case questionTitle = "Question.title"
        case questionCategoryID = "Question.Category.id"
        case questionCategoryName = "Question.Category.name"
        case isToday = "is_today"
    }
}

