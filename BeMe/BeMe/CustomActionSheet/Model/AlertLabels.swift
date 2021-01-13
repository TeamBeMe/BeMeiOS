//
//  Model.swift
//  BeMe
//
//  Created by 이재용 on 2021/01/07.
//

import Foundation

struct AlertLabels {
    
    let icons: [String]
    let names: [String]
    
    static let otherCommentNotMyArticle: AlertLabels = AlertLabels(icons: ["icDeclare", "icBlock"], names: ["신고하기", "차단하기"])
    static let otherCommentNotMyArticleNoBlock: AlertLabels = AlertLabels(icons: ["icDeclare", "icBlock"], names: ["신고하기", "차단하기"])
    
    static let otherCommentMyArticle: AlertLabels = AlertLabels(icons: ["icDeclare", "icBlock", "icDeleteBlack"], names: ["신고하기", "차단하기", "댓글 삭제"])
    static let otherCommentMyArticleNoBlock: AlertLabels = AlertLabels(icons: ["icDeclare", "icDeleteBlack"], names: ["신고하기", "댓글 삭제"])
    static let myComment: AlertLabels = AlertLabels(icons: ["icEditBlack", "icDeleteBlack"], names: ["댓글 수정", "댓글 삭제"])
    static let article: AlertLabels = AlertLabels(icons: ["icShare", "icDeclare", "icBlock"], names: ["공유", "신고", "차단"])
    
    static let followerReport: AlertLabels = AlertLabels(icons: ["icDeclare", "icFollowDelete"], names: ["신고하기","팔로워 삭제"])
    
}
