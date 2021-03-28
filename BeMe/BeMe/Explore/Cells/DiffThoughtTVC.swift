//
//  DiffThoughtTVC.swift
//  BeMe
//
//  Created by 이재용 on 2021/01/08.
//

import UIKit

class DiffThoughtTVC: UITableViewCell {
    static let identifier: String = "DiffThoughtTVC"
    
    weak var delegate: UITableViewButtonSelectedDelegate?
    
    
    private var currentIndex: CGFloat = 0
    
    private var isOneStepPaging = true
    
    var questionId: Int?
        
    var isEmpty = false
    
//    var exploreThoughtArray: [ExploreThoughtData] = [] {
//        didSet {
//            diffThoughtCollectionView.reloadData()
//        }
//    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = .white

    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
//    private func setThoughtCollectionView() {
//        diffThoughtCollectionView.delegate = self
//        diffThoughtCollectionView.dataSource = self
//
//        if isEmpty {
//            let cellWidth: CGFloat = UIScreen.main.bounds.width
//            let cellHeight = cellWidth * 229.0 / 320.0
//            let layout = diffThoughtCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
//            layout.itemSize = CGSize(width: cellWidth, height: cellHeight)
//            diffThoughtCollectionView.contentInset = UIEdgeInsets(top: 16, left: 0, bottom: 30, right: 0)
//
//        } else {
//            let cellWidth: CGFloat = UIScreen.main.bounds.width - 55.0
//            let cellHeight: CGFloat = cellWidth * 229.0 / 320.0
//
//            // 상하, 좌우 inset value 설정
//            let insetX: CGFloat = (UIScreen.main.bounds.width - cellWidth) / 2.0
//            let lineSpacing: CGFloat = 12.0
//
//            let layout = diffThoughtCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
//            layout.itemSize = CGSize(width: cellWidth, height: cellHeight)
//            layout.minimumLineSpacing = lineSpacing
//            layout.scrollDirection = .horizontal
//            diffThoughtCollectionView.contentInset = UIEdgeInsets(top: 16, left: insetX, bottom: 30, right: insetX)
//            diffThoughtCollectionView.decelerationRate = UIScrollView.DecelerationRate.fast
//        }
//
//    }
    
    
    @IBAction func friendButtonTapped(_ sender: Any) {
        delegate?.goToFriendButtonDidTapped()
    }
    
    @IBAction func alarmButtonTapped(_ sender: Any) {
        delegate?.goToAlarmButtonDidTapped()
        
    }
}

//extension DiffThoughtTVC: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
//
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        if isEmpty {
//            return 1
//        } else {
//            return exploreThoughtArray.count
//        }
//
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        if isEmpty {
//            guard let empty = collectionView.dequeueReusableCell(withReuseIdentifier: EmptyThoughtCVC.identifier, for: indexPath) as? EmptyThoughtCVC else { return UICollectionViewCell() }
//
//            empty.delegate = self
//            empty.todayButton.makeRound(to: 6.0)
//            return empty
//        } else {
//            guard let card = collectionView.dequeueReusableCell(withReuseIdentifier: DiffThoughtCVC.identifier, for: indexPath) as? DiffThoughtCVC else { return UICollectionViewCell() }
//            card.delegate = self
//
//            card.makeRounded(cornerRadius: 6.0)
//            card.setQuestionAnswer(exploreThoughtArray[indexPath.item].questionTitle, exploreThoughtArray[indexPath.item].content, answerId:exploreThoughtArray[indexPath.item].id , questionId: exploreThoughtArray[indexPath.item].questionID)
//            return card
//        }
//    }
//}
//
//extension DiffThoughtTVC: UICollectionViewButtonDelegate {
//    func goToOneQuestionMoreAnswerButtonDidTapped(_ questionId: Int, question: String) {
//
//        delegate?.goToMoreAnswerButtonDidTapped(questionId: questionId, question: question)
//    }
//
//    func goToAnswerDetailButtonDidTapped(_ answerId: Int) {
//
//        delegate?.goToCommentButtonTapped(answerId)
//    }
//
//    func goToTodayAnswerButtonDidTapped() {
//        print("second")
//        delegate?.goToTodayAnswerButtonDidTapped()
//    }
//}
//
//extension DiffThoughtTVC: UIScrollViewDelegate {
//    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>)
//    {
//        if scrollView == diffThoughtCollectionView {
//            let layout = self.diffThoughtCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
//            let cellWidthIncludingSpacing = layout.itemSize.width + layout.minimumLineSpacing
//
//            var offset = targetContentOffset.pointee
//            let index = (offset.x + scrollView.contentInset.left) / cellWidthIncludingSpacing
//            var roundedIndex = round(index)
//
//            if scrollView.contentOffset.x > targetContentOffset.pointee.x {
//                roundedIndex = floor(index)
//            } else if scrollView.contentOffset.x < targetContentOffset.pointee.x {
//                roundedIndex = ceil(index)
//            } else {
//                roundedIndex = round(index)
//            }
//
//            if isOneStepPaging {
//                if currentIndex > roundedIndex {
//                    currentIndex -= 1
//                    roundedIndex = currentIndex
//                } else if currentIndex < roundedIndex {
//                    currentIndex += 1
//                    roundedIndex = currentIndex
//                }
//            }
//
//            offset = CGPoint(x: roundedIndex * cellWidthIncludingSpacing - scrollView.contentInset.left, y: -scrollView.contentInset.top)
//            targetContentOffset.pointee = offset
//        }
//
//
//    }
//}


protocol UICollectionViewButtonDelegate: class {
    func goToOneQuestionMoreAnswerButtonDidTapped(_ questionId: Int, question: String)
    
    func goToAnswerDetailButtonDidTapped(_ answerId: Int)
    
    func goToTodayAnswerButtonDidTapped()
}

extension UICollectionViewButtonDelegate {
    func goToOneQuestionMoreAnswerButtonDidTapped(_ questionId: Int, question: String) {}
    
    func goToAnswerDetailButtonDidTapped(_ answerId: Int) {}
    
    func goToTodayAnswerButtonDidTapped() {}
}
