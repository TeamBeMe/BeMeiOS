//
//  SignUpData.swift
//  BeMe
//
//  Created by Yunjae Kim on 2021/01/05.
//

import Foundation

struct SignUpData: Codable {
    let id: Int
    let email, nickname: String
    let profileImg: String?

    enum CodingKeys: String, CodingKey {
        case id, email, nickname
        case profileImg = "profile_img"
    }
}
