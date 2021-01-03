//
//  AnswerDataForViewController.swift
//  BeMe
//
//  Created by Yunjae Kim on 2021/01/02.
//

import Foundation

struct AnswerDataForViewController {
    var lock: Bool?
    var questionInfo: String?
    var answerDate: String?
    var question: String?
    var answer: String?
    var index: Int?
    
    init(lock: Bool, questionInfo: String, answerDate: String, question: String, answer: String, index: Int) {
        self.lock = lock
        self.questionInfo = questionInfo
        self.answerDate = answerDate
        self.question = question
        self.answer = answer
        self.index = index
    }
    
}
