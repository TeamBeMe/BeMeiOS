//
//  SearchHistoryData.swift
//  BeMe
//
//  Created by Yunjae Kim on 2021/01/11.
//

import Foundation
struct SearchHistoryData: Codable {
    let id: Int
    let nickname: String
    let profileImg: String?

    enum CodingKeys: String, CodingKey {
        case id, nickname
        case profileImg = "profile_img"
    }
}
