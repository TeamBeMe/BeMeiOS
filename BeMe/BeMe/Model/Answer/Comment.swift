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
    let children: [Comment] // 대댓글은 대댓글을 포함하고 있지 않다.
    let isAuthor, isVisible: Bool
    let parentID: Int
    let userNickname: String
    let profileImg: String
    var open: Bool
    
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = (try? values.decode(Int.self, forKey: .id)) ?? -1
        content = (try? values.decode(String.self, forKey: .content)) ?? ""
        publicFlag = (try? values.decode(Bool.self, forKey: .publicFlag)) ?? false
        userID = (try? values.decode(Int.self, forKey: .userID)) ?? -1
        answerID = (try? values.decode(Int.self, forKey: .answerID)) ?? -1
        createdAt = (try? values.decode(String.self, forKey: .createdAt)) ?? ""
        updatedAt = (try? values.decode(String.self, forKey: .updatedAt)) ?? ""
        children = (try? values.decode([Comment].self, forKey: .children)) ?? []
        isAuthor = (try? values.decode(Bool.self, forKey: .isAuthor)) ?? false
        isVisible = (try? values.decode(Bool.self, forKey: .isVisible)) ?? false
        parentID = (try? values.decode(Int.self, forKey: .parentID)) ?? -1
        userNickname = (try? values.decode(String.self, forKey: .userNickname )) ?? ""
        profileImg = (try? values.decode(String.self, forKey: .profileImg )) ?? ""
        open = (try? values.decode(Bool.self, forKey: .open)) ?? false
    }
    
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
        case userNickname = "user_nickname"
        case profileImg = "profile_img"
        case open
    }
}
