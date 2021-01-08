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
    
}
