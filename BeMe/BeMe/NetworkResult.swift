//
//  NetworkResult.swift
//  BeMe
//
//  Created by Yunjae Kim on 2020/12/28.
//

import Foundation

enum NetworkResult<T> {
    case success(T)
    case requestErr(T)
    case pathErr
    case serverErr
    case networkFail
}
