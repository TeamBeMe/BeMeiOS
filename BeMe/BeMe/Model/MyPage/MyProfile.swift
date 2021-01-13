//
//  MyProfile.swift
//  BeMe
//
//  Created by 박세란 on 2021/01/13.
//

import Foundation

// MARK: - DataClass
struct MyProfile: Codable {
    let id: Int
    let nickname, email: String
    let profileImg: String?
    let continuedVisit: Int
    let answerCount: Int
    
    enum CodingKeys: String, CodingKey {
        case id, nickname, email
        case profileImg = "profile_img"
        case continuedVisit = "continued_visit"
        case answerCount = "answer_count"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = (try? values.decode(Int.self, forKey: .id)) ?? -1
        nickname = (try? values.decode(String.self, forKey: .nickname)) ?? ""
        email = (try? values.decode(String.self, forKey: .email)) ?? ""
        profileImg = (try? values.decode(String.self, forKey: .profileImg)) ?? ""
        continuedVisit = (try? values.decode(Int.self, forKey: .continuedVisit)) ?? -1
        answerCount = (try? values.decode(Int.self, forKey: .answerCount)) ?? -1
        
    }
}
