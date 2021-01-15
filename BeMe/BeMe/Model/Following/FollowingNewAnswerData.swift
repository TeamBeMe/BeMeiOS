//
//  FollowingNewAnswerData.swift
//  BeMe
//
//  Created by Yunjae Kim on 2021/01/14.
//

import Foundation

struct FollowingNewAnswerData: Codable {
    let id, answerIdx: Int
    let createdAt: String
    let userID, questionID: Int
    let question, category: String
    let categoryID: Int

    enum CodingKeys: String, CodingKey {
        case id
        case answerIdx = "answer_idx"
        case createdAt
        case userID = "user_id"
        case questionID = "question_id"
        case question, category
        case categoryID = "category_id"
    }
}
