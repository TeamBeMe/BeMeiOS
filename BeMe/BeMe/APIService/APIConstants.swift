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
    
    // Exploration Tab
    static let explorationCategoryURL = baseURL + "/exploration/category"
    static let explorationDiffThoughtURL = baseURL + "/exploration/another"
    static let explorationDiffArticleURL = baseURL + "/exploration"
}
