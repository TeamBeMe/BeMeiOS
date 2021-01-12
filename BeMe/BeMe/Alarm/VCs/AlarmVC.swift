//
//  AlarmVC.swift
//  BeMe
//
//  Created by 이재용 on 2021/01/12.
//

import UIKit

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

// MARK: - Activity
struct Alarm: Codable {
    let type: String
    let userID: Int
    let userNickname: String
    let profileImg: String
    let questionTitle: String
    let createdAt: String
    enum CodingKeys: String, CodingKey {
        case type
        case userID = "user_id"
        case userNickname = "user_nickname"
        case profileImg = "profile_img"
        case questionTitle = "question_title"
        case createdAt
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        type = (try? values.decode(String.self, forKey: .type)) ?? ""
        userID = (try? values.decode(Int.self, forKey: .userID)) ?? -1
        userNickname = (try? values.decode(String.self, forKey: .userNickname)) ?? ""
        profileImg = (try? values.decode(String.self, forKey: .profileImg)) ?? ""
        questionTitle = (try? values.decode(String.self, forKey: .questionTitle)) ?? ""
        createdAt = (try? values.decode(String.self, forKey: .createdAt)) ?? ""
    }
}

class AlarmVC: UIViewController {

    @IBOutlet weak var alarmTableView: UITableView!
    
    private let page: Int = 1
    
    private let currentPage: Int = 1
    
    private let alarmArray: [Alarm] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

}

extension AlarmVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return alarmArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AlarmTVC.identifier, for: indexPath) as? AlarmTVC else { return UITableViewCell() }
        
        return cell
    }
    
    
}

extension AlarmVC: UITableViewDelegate {
    
}
