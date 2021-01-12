//
//  Alarm.swift
//  BeMe
//
//  Created by 이재용 on 2021/01/12.
//

import Foundation

struct AlarmData: Codable {
    let pageLen: Int
    let activities: [Alarm]

    enum CodingKeys: String, CodingKey {
        case pageLen = "page_len"
        case activities
    }
    
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        pageLen = (try? values.decode(Int.self, forKey: .pageLen)) ?? -1
        activities = (try? values.decode([Alarm].self, forKey: .activities)) ?? []
    }
}
