//
//  Answer.swift
//  BeMe
//
//  Created by 이재용 on 2021/01/08.
//

import Foundation

struct ExploreAnswer: Codable {
    let id: Int
    let commentBlockedFlag: Bool
    let content: String
    let publicFlag: Bool
    let answerDate: String
    let answerIdx: Int?
    let questionID, userID: Int
    let isAuthor, isScrapped: Bool
    let userProfile: String
    let userNickname: String
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
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = (try? values.decode(Int.self, forKey: .id)) ?? -1
        commentBlockedFlag = (try? values.decode(Bool.self, forKey: .commentBlockedFlag)) ?? false
        content = (try? values.decode(String.self, forKey: .content)) ?? ""
        publicFlag = (try? values.decode(Bool.self, forKey: .publicFlag)) ?? false
        answerDate = (try? values.decode(String.self, forKey: .answerDate)) ?? ""
        answerIdx = (try? values.decode(Int.self, forKey: .answerIdx)) ?? -1
        questionID = (try? values.decode(Int.self, forKey: .questionID)) ?? -1
        userID = (try? values.decode(Int.self, forKey: .userID)) ?? -1
        isAuthor = (try? values.decode(Bool.self, forKey: .isAuthor)) ?? false
        isScrapped = (try? values.decode(Bool.self, forKey: .isScrapped)) ?? false
        userProfile = (try? values.decode(String.self, forKey: .userProfile)) ?? ""
        userNickname = (try? values.decode(String.self, forKey: .userNickname)) ?? ""
        question = (try? values.decode(String.self, forKey: .question)) ?? ""
        category = (try? values.decode(String.self, forKey: .category)) ?? ""
        categoryID = (try? values.decode(Int.self, forKey: .categoryID)) ?? -1
        isAnswered = (try? values.decode(Bool.self, forKey: .isAnswered)) ?? false
    }
}
