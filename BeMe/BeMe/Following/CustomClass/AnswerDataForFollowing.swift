//
//  AnswerDataInFollowing.swift
//  BeMe
//
//  Created by Yunjae Kim on 2021/01/09.
//

import Foundation

struct AnswerDataForFollowing: Codable {
    let id: Int
    let commentBlockedFlag: Bool
    let content: String?
    let publicFlag: Bool
    let answerDate: String?
    let answerIdx, questionID, userID: Int
    let isAuthor, isScrapped: Bool
    let userProfile: String?
    let userNickname: String?
    let question, category: String
    let categoryID: Int
    let isAnswered: Bool

    
    init(id: Int,commentBlock: Bool,content: String,publicFlag: Bool, answerDate:String,
         answerIdx: Int,questionID: Int, userID: Int,isAuthor: Bool,isScrapped: Bool,
         userProfile: String, userNickname: String,question:String,category: String,
         categoryID: Int, isAnswerd: Bool) {
        
        self.id = id
        self.commentBlockedFlag = commentBlock
        self.content = content
        self.publicFlag = publicFlag
        self.answerDate = answerDate
        self.answerIdx = answerIdx
        self.questionID = questionID
        self.userID = userID
        self.isAuthor = isAuthor
        self.isScrapped = isScrapped
        self.userProfile = userProfile
        self.userNickname = userNickname
        self.question = question
        self.category = category
        self.categoryID = categoryID
        self.isAnswered = isAnswerd

    }
    
}
