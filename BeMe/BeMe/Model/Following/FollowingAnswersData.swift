//
//  FollowingAnswersData.swift
//  BeMe
//
//  Created by Yunjae Kim on 2021/01/09.
//

import Foundation
struct FollowingAnswersData: Codable {
    let pageLen: Int
    let answers: [FollowingAnswers]

    enum CodingKeys: String, CodingKey {
        case pageLen = "page_len"
        case answers
    }
}

// MARK: - Answer
struct FollowingAnswers: Codable {
    let id: Int
    let commentBlockedFlag: Bool
    let content: String?
    let publicFlag: Bool
    let answerDate: String?
    let answerIdx, questionID, userID: Int
    let isAuthor, isScrapped: Bool
    let userProfile: String?
    let userNickname: String?
    let question, category: String
    let categoryID: Int
    let isAnswered: Bool

    enum CodingKeys: String, CodingKey {
        case id
        case commentBlockedFlag = "comment_blocked_flag"
        case content
        case publicFlag = "public_flag"
        case answerDate = "answer_date"
        case answerIdx = "answer_idx"
        case questionID = "question_id"
        case userID = "user_id"
        case isAuthor = "is_author"
        case isScrapped = "is_scrapped"
        case userProfile = "user_profile"
        case userNickname = "user_nickname"
        case question, category
        case categoryID = "category_id"
        case isAnswered = "is_answered"
    }
}
