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
    static let signupDuplicateURL = baseURL+"/users?nickname="
    static let loginURL = baseURL+"/users/signin"
    static let homeGetURL = baseURL+"/home/all/"
    static let homeGetNewQuestionURL = baseURL + "/home"
    static let homeChangeQuestionURL = baseURL + "/home/"
    static let homeChangePublicURL = baseURL + "/home/public"
    static let homeDeleteAnswerURL = baseURL + "/home/"
    static let answerRegistURL = baseURL+"/answers"
    static let answerModifyURL = baseURL+"/answers"
    static let followGetURL = baseURL+"/follow"
    static let findPeopleSearchURL = baseURL+"/users/search?"
    static let followingfollowURL = baseURL+"/follow"
    static let followingGetAnswerURL = baseURL+"/follow/answers?"
    static let searchHistoryURL = baseURL+"/users/search/history"
    static let searchDeleteURL = baseURL+"/users/search/"
    static let followerDeleteURL = baseURL+"/follow/"
    
    
    static let explorationCategoryURL = baseURL + "/exploration/category"
    static let explorationDiffThoughtURL = baseURL + "/exploration/another"
    static let explorationDiffArticleURL = baseURL + "/exploration"
    static let explorationAnswerScapURL = baseURL + "/exploration/"
    static let explorationDetailAnswerURL = baseURL + "/exploration/"
    static let answerDetailURL = baseURL + "/answers/detail"
    static let answerCommentURL = baseURL + "/answers/comments"
    
    static let othersPageProfileURL = baseURL + "/profiles/"
    static let othersPageAnswerURL = baseURL + "/profiles/answers/"
    
    static let myPageProfileURL = baseURL + "/profiles"
    static let myPageAnswerURL = baseURL + "/profiles/answers?"
    static let myPageScrapURL = baseURL + "/profiles/scraps?"
//    static let settingMyPageProfileURL = baseURL + "/profiles"
    
    
    
}
