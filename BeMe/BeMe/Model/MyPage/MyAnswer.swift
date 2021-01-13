//
//  MyAnswer.swift
//  BeMe
//
//  Created by 박세란 on 2021/01/13.
//

import Foundation

// MARK: - DataClass
struct MyAnswer: Codable {
    let pageLen: Int
    let answers: [Answer]

    enum CodingKeys: String, CodingKey {
        case pageLen = "page_len"
        case answers
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        pageLen = (try? values.decode(Int.self, forKey: .pageLen)) ?? -1
        answers = (try? values.decode([Answer].self, forKey: .answers)) ?? []
    }
}

