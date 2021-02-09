//
//  AnswerDataForViewController.swift
//  BeMe
//
//  Created by Yunjae Kim on 2021/01/02.
//

import Foundation

struct AnswerDataForViewController {
    var lock: Bool?
    var questionCategory: String?
    var answerDate: String?
    var question: String?
    var answer: String?
    var index: Int?
    var answerIdx: Int?
    
    var questionID: Int?
    var createdTime: String?
    var categoryID: Int?
    var id: Int?
    var commentPublicFlag: Int?
    
    init(lock: Bool, questionCategory: String, answerDate: String,
         question: String, answer: String, index: Int, answerIdx: Int,
         questionID: Int, createdTime: String,categoryID: Int?,id: Int,commentPublicFlag: Int) {
        self.lock = lock
        self.questionCategory = questionCategory
        self.answerDate = answerDate
        self.question = question
        self.answer = answer
        self.index = index
        self.answerIdx = answerIdx
        self.questionID = questionID
        self.createdTime = createdTime
        self.categoryID = categoryID
        self.id = id
        self.commentPublicFlag = commentPublicFlag
    }
    
}
