//
//  OthersProfile.swift
//  BeMe
//
//  Created by 박세란 on 2021/01/11.
//

import Foundation

// MARK: - DataClass
struct OthersProfile: Codable {
    let id: Int
    let nickname, email: String
    let profileImg: String?
    let continuedVisit: Int
    let isFollowed: Bool
    let answerCount: Int
    
    enum CodingKeys: String, CodingKey {
        case id, nickname, email
        case profileImg = "profile_img"
        case continuedVisit = "continued_visit"
        case isFollowed = "is_followed"
        case answerCount = "answer_count"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = (try? values.decode(Int.self, forKey: .id)) ?? -1
        nickname = (try? values.decode(String.self, forKey: .nickname)) ?? ""
        email = (try? values.decode(String.self, forKey: .email)) ?? ""
        profileImg = (try? values.decode(String.self, forKey: .profileImg)) ?? ""
        continuedVisit = (try? values.decode(Int.self, forKey: .continuedVisit)) ?? -1
        isFollowed = (try? values.decode(Bool.self, forKey: .isFollowed)) ?? false
        answerCount = (try? values.decode(Int.self, forKey: .answerCount)) ?? -1
        
    }
}
