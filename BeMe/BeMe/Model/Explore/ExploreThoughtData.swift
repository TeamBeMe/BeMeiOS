//
//  ExploreThoughtInformation.swift
//  BeMe
//
//  Created by 이재용 on 2021/01/08.
//

import Foundation

// MARK: - ExploreThoughtData
struct ExploreThoughtData: Codable {
    let id, questionID: Int
    let content: String
    let questionTitle: String
    let commentCount: Int
    
    enum CodingKeys: String, CodingKey {
        case id
        case questionID = "question.id"
        case content
        case commentCount = "comment_count"
        case questionTitle = "Question.title"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = (try? values.decode(Int.self, forKey: .id)) ?? -1
        questionID = (try? values.decode(Int.self, forKey: .questionID)) ?? -1
        content = (try? values.decode(String.self, forKey: .content)) ?? ""
        commentCount = (try? values.decode(Int.self, forKey: .commentCount)) ?? -1
        questionTitle = (try? values.decode(String.self, forKey: .questionTitle)) ?? ""
    }
}
