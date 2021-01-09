//
//  APIConstants.swift
//  BeMe
//
//  Created by Yunjae Kim on 2020/12/28.
//

import Foundation

struct APIConstants{
    static let baseURL = "http://15.164.67.58:3000"
    
    static let signupURL = baseURL+"/users/signup"
    static let loginURL = baseURL+"/users/signin"
    static let homeGetURL = baseURL+"/home/all/"
    static let homeGetNewQuestionURL = baseURL + "/home"
    static let homeChangeQuestionURL = baseURL + "/home/"
    static let homeChangePublicURL = baseURL + "/home/public"
    static let homeDeleteAnswerURL = baseURL + "/home/"
    static let answerRegistURL = baseURL+"/answers"
    static let answerModifyURL = baseURL+"/answers"
    static let followGetURL = baseURL+"/follow"
    
    // Exploration Tab
    static let explorationCategoryURL = baseURL + "/exploration/category"
    static let explorationDiffThoughtURL = baseURL + "/exploration/another"
    static let explorationDiffArticleURL = baseURL + "/exploration"
    static let explorationAnswerScapURL = baseURL + "/exploration/"
    static let explorationDetailAnswerURL = baseURL + "/exploration/"
}
