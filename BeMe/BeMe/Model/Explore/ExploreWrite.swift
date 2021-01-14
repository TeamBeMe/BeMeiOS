//
//  ExploreWrite.swift
//  BeMe
//
//  Created by 이재용 on 2021/01/14.
//

import Foundation

struct ExploreWrite: Codable {
    let id, answerIdx: Int
    let createdAt: String
    let questionID: Int
    let questionTitle: String
    let questionCategoryID: Int
    let questionCategoryName: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case answerIdx = "answer_idx"
        case createdAt = "created_at"
        case questionID = "Question.id"
        case questionTitle = "Question.title"
        case questionCategoryID = "Question.Category.id"
        case questionCategoryName = "Question.Category.name"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = (try? values.decode(Int.self, forKey: .id)) ?? -1
        answerIdx = (try? values.decode(Int.self, forKey: .answerIdx)) ?? -1
        createdAt = (try? values.decode(String.self, forKey: .createdAt)) ?? ""
        questionID = (try? values.decode(Int.self, forKey: .questionID)) ?? -1
        questionTitle = (try? values.decode(String.self, forKey: .questionTitle)) ?? ""
        questionCategoryID = (try? values.decode(Int.self, forKey: .questionCategoryID)) ?? -1
        questionCategoryName = (try? values.decode(String.self, forKey: .questionCategoryName)) ?? ""
        
    }
    
}
