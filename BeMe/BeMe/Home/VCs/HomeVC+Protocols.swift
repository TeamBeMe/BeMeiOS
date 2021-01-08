//
//  HomeVC+Protocols.swift
//  BeMe
//
//  Created by Yunjae Kim on 2021/01/02.
//

import Foundation
protocol AddQuestionDelegate{
    
    func addQuestion()
    
    
}

protocol ChangePublicDelegate{
    
    func changePublic(idx: Int,answerID: Int)
    
}



protocol HomeTabBarDelegate {
    func homeButtonTapped()
    
}

protocol HomeFixButtonDelegate {
    func fixButtonTapped(idx: Int)
    
}

protocol HomeAnswerButtonDelegate{
    func answerButtonTapped(index: Int,answerData: AnswerDataForViewController)
}

protocol HomeGetDataFromAnswerDelegate{
    func setNewAnswer(answerData: AnswerDataForViewController)
}

protocol HomeChangeQuestionDelegate{
    func getNewQuestion(idx: Int,answerID: Int)
    
    
}
