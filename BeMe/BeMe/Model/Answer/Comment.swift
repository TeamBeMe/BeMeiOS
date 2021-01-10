//
//  Comment.swift
//  BeMe
//
//  Created by 이재용 on 2021/01/10.
//

import Foundation

struct Comment: Codable {
    let id: Int
    let content: String
    let publicFlag: Bool
    let userID, answerID: Int
    let createdAt, updatedAt: String
    let children: [Comment]? // 대댓글은 대댓글을 포함하고 있지 않다.
    let isAuthor, isVisible: Bool
    let parentID: Int?

    enum CodingKeys: String, CodingKey {
        case id, content
        case publicFlag = "public_flag"
        case userID = "user_id"
        case answerID = "answer_id"
        case createdAt, updatedAt
        case children = "Children"
        case isAuthor = "is_author"
        case isVisible = "is_visible"
        case parentID = "parent_id"
    }
}
