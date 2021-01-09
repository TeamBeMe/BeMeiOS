//
//  DiffArticleInformation.swift
//  BeMe
//
//  Created by 이재용 on 2021/01/08.
//

import Foundation

struct ExploreAnswerData: Codable {
    let pageLen: Int
    let answers: [ExploreAnswer]?
    
    enum CodingKeys: String, CodingKey {
        case pageLen = "page_len"
        case answers
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        pageLen = (try? values.decode(Int.self, forKey: .pageLen)) ?? -1
        answers = (try? values.decode([ExploreAnswer].self, forKey: .answers)) ?? nil
    }
}
