//
//  HomeGetPageData.swift
//  BeMe
//
//  Created by Yunjae Kim on 2021/01/06.
//

import Foundation
// MARK: - Datum
struct HomePageData: Codable {
    let id: Int?
    let answerIdx: Int?
    let content: String?
    let createdAt: String?
    let answerDate: String?
    let question: HomePageQuestion?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case answerIdx = "answer_idx"
        case content = "content"
        case createdAt = "created_at"
        case answerDate = "answer_date"
        case question = "Question"
    }
}

// MARK: - Question
struct HomePageQuestion: Codable {
    let id: Int
    let title: String
    let category: HomePageCategory

    enum CodingKeys: String, CodingKey {
        case id, title
        case category = "Category"
    }
}

// MARK: - Category
struct HomePageCategory: Codable {
    let id: Int
    let name: String
}
