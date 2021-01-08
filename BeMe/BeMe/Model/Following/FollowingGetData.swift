//
//  FollowingFollowData.swift
//  BeMe
//
//  Created by Yunjae Kim on 2021/01/08.
//

import Foundation

struct FollowingGetData: Codable {
    let followers, followees: [FollowingFollows]
}

// MARK: - Followe
struct FollowingFollows: Codable {
    let id: Int?
    let nickname: String?
    let profileImg: String?

    enum CodingKeys: String, CodingKey {
        case id, nickname
        case profileImg = "profile_img"
    }
}
