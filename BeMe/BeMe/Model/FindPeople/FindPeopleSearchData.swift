//
//  FindPeopleSearchService.swift
//  BeMe
//
//  Created by Yunjae Kim on 2021/01/09.
//

import Foundation


struct FindPeopleSearchData: Codable {
    let id: Int
    let nickname: String
    let profileImg: String?
    let isFollowed: Bool

    enum CodingKeys: String, CodingKey {
        case id, nickname
        case profileImg = "profile_img"
        case isFollowed = "is_followed"
    }
}
