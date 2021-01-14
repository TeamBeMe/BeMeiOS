//
//  UITableViewButtonSelectedDelegate.swift
//  BeMe
//
//  Created by 이재용 on 2021/01/06.
//

import Foundation

protocol UITableViewButtonSelectedDelegate: class {
    
    // 탐색 디테일 페이지의 설정 버튼 눌릴때 + 댓글 페이지의 설정 버튼 누를때
    func settingButtonDidTapped(to indexPath: IndexPath, isAuthor: Bool, commentId: Int, content: String)
    
    // 댓글 페이지의 댓글 보기 버튼 눌릴 때
    func moreCellButtonDidTapped(to indexPath: IndexPath, isSecret: Int)
    
    // detail 화면으로 넘어가는 것을 알려줄때
    func goToMoreAnswerButtonDidTapped(questionId: Int, question: String)
    
    // 댓글 페이지의 답글 달기 버튼 눌릴 때
    func sendCommentButtonDidTapped(to indexPath: IndexPath, nickName: String, parentId: Int)
    
    // 카테고리 버튼 누를 때
    func categoryButtonTapped(_ indexPath: IndexPath, _ cateogoryId: Int)
    
    // 최신 흥미 버튼 누를 때
    func recentOrFavoriteButtonTapped(_ indexPath: Int, _ selected: String)
    
    // 더 많은 답변 보기 버튼 누를 때
    func exploreMoreAnswersButtonDidTapped()
    
    // 답변 스크랩하기
    func exploreAnswerScrapButtonDidTapped(_ answerId: Int)
    
    // 댓글 화면으로 넘어갈 때
    func goToCommentButtonTapped(_ answerId: Int)
    
    // 알람 화면으로 넘어가는 버튼 눌렀을 때
    func goToAlarmButtonDidTapped()
    
    // friend 화면으로 넘어가는 버튼 눌렀을 때
    func goToFriendButtonDidTapped()
    
    // 탐색에서 오늘 질문 답변하기 버튼 눌렀을 때
    func goToTodayAnswerButtonDidTapped()
    
    // 다른 프로필로 넘어가는 버튼 눌렀을 때
    func goToOthersProfileButtonDidTapped(_ userId: Int)
}

extension UITableViewButtonSelectedDelegate {
    func settingButtonDidTapped(to indexPath: IndexPath, isAuthor: Bool, commentId: Int, content: String) {}
    
    func moreCellButtonDidTapped(to: IndexPath, isSecret: Int) {}
    
    func goToMoreAnswerButtonDidTapped(questionId: Int, question: String) {}
    
    func sendCommentButtonDidTapped(to indexPath: IndexPath, nickName: String, parentId: Int) {}
    
    func categoryButtonTapped(_ indexPath: IndexPath, _ cateogoryId: Int) {}
    
    func recentOrFavoriteButtonTapped(_ whichOne: Int, _ selected: String) {}
    
    func exploreMoreAnswersButtonDidTapped() {}
    
    func exploreAnswerScrapButtonDidTapped(_ answerId: Int) {}
    
    func goToCommentButtonTapped(_ answerId: Int) {}
    
    func goToAlarmButtonDidTapped() {}
    
    func goToFriendButtonDidTapped() {}
    
    func goToTodayAnswerButtonDidTapped() {}
    
    func goToOthersProfileButtonDidTapped(_ userId: Int) {}
}
