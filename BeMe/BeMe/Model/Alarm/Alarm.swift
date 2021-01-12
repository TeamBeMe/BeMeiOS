//
//  Alarm.swift
//  BeMe
//
//  Created by 이재용 on 2021/01/12.
//

import Foundation

struct Alarm: Codable {
    let type: String
    let userID: Int
    let userNickname: String
    let profileImg: String
    let questionTitle: String
    let createdAt: String
    let answerId: Int
    
    enum CodingKeys: String, CodingKey {
        case type
        case userID = "user_id"
        case userNickname = "user_nickname"
        case profileImg = "profile_img"
        case questionTitle = "question_title"
        case createdAt
        case answerId = "answer_id"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        type = (try? values.decode(String.self, forKey: .type)) ?? ""
        userID = (try? values.decode(Int.self, forKey: .userID)) ?? -1
        userNickname = (try? values.decode(String.self, forKey: .userNickname)) ?? ""
        profileImg = (try? values.decode(String.self, forKey: .profileImg)) ?? ""
        questionTitle = (try? values.decode(String.self, forKey: .questionTitle)) ?? ""
        createdAt = (try? values.decode(String.self, forKey: .createdAt)) ?? ""
        answerId = (try? values.decode(Int.self, forKey: .answerId)) ?? -1
    }
}
