//
//  CommentVC.swift
//  BeMe
//
//  Created by 이재용 on 2021/01/05.
//

import UIKit

//MARK: - Comment 모델
struct Comment: Codable {
    let id: Int
    let content: String
    let publicFlag: Bool
    let userID, answerID: Int
    let createdAt, updatedAt: String
    let children: [Comment]?
    let isAuthor: Bool
    let parentID: Int?
    
    enum CodingKeys: String, CodingKey {
        case id, content
        case publicFlag = "public_flag"
        case userID = "user_id"
        case answerID = "answer_id"
        case createdAt, updatedAt
        case children = "Children"
        case isAuthor = "is_author"
        case parentID = "parent_id"
    }
}

struct CommentA {
    let comment: String
    let children: [CommentA]?
}

class CommentVC: UIViewController {
    
    @IBOutlet weak var informationView: UIView!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var cateogryLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nickNameLabel: UILabel!
    @IBOutlet weak var answerTextView: UITextView!
    @IBOutlet weak var moreAnswerButton: UIButton!
    @IBOutlet weak var commentTableView: UITableView!
    @IBOutlet weak var commentTableViewHeight: NSLayoutConstraint!
    
    private var commentArray: [CommentA] = [
        CommentA(comment: "안녕!", children: [CommentA(comment: "오! 안녕!", children: []),
                                                CommentA(comment: "오! 안녕!", children: []),
                                                CommentA(comment: "오! 안녕!", children: [])]),
        CommentA(comment: "안녕!", children: []),
        CommentA(comment: "안녕!", children: [CommentA(comment: "오! 안녕!", children: []),
                                                CommentA(comment: "오! 안녕!", children: [])]),
        CommentA(comment: "안녕!", children: [CommentA(comment: "오! 안녕!", children: []),
                                                CommentA(comment: "오! 안녕!", children: []),
                                                CommentA(comment: "오! 안녕!", children: [])]),
    ]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setView()
        setTableView()
        moreAnswerButton.isHidden = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        commentTableViewHeight.constant = commentTableView.contentSize.height
    }
    
}
//MARK: - Private Method
extension CommentVC {
    
    private func setView() {
        
    }
    
    private func setTableView() {
        commentTableView.estimatedRowHeight = 400
        commentTableView.delegate = self
        commentTableView.dataSource = self
    }
}

//MARK: - UITableViewDelegate

extension CommentVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        print(commentArray.count + 1)
        return commentArray.count + 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
//            print(commentArray[section-1].children?.count)
            return commentArray[section - 1].children?.count ?? 0
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let header = tableView.dequeueReusableCell(withIdentifier: TitleTVC.identifier, for: indexPath) as? TitleTVC else { return UITableViewCell() }
            
            return header
        } else {
            if indexPath.row == 0 {
                guard let comment = tableView.dequeueReusableCell(withIdentifier: CommentTVC.identifier, for: indexPath) as? CommentTVC else { return UITableViewCell() }
                
                return comment
            } else {
                guard let secondComment = tableView.dequeueReusableCell(withIdentifier: SecondCommentTVC.identifier, for: indexPath) as? SecondCommentTVC else { return UITableViewCell() }
                secondComment.backgroundColor = ((indexPath.row % 2) != 0) ? UIColor.yellow : UIColor.red
                return secondComment
            }
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
