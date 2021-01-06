//
//  HomeNewQuestionData.swift
//  BeMe
//
//  Created by Yunjae Kim on 2021/01/06.
//

import Foundation


// MARK: - DataClass
struct HomeNewQuestionData: Codable {
    let id: Int
    let answerIdx: Int?
    let content: String?
    let createdAt: String
    let answerDate: String?
    let question: NewQuestion

    enum CodingKeys: String, CodingKey {
        case id
        case answerIdx = "answer_idx"
        case content
        case createdAt = "created_at"
        case answerDate = "answer_date"
        case question = "Question"
    }
}

// MARK: - Question
struct NewQuestion: Codable {
    let id: Int
    let title: String
    let category: NewQuestionCategory

    enum CodingKeys: String, CodingKey {
        case id, title
        case category = "Category"
    }
}

// MARK: - Category
struct NewQuestionCategory: Codable {
    let id: Int
    let name: String
}
