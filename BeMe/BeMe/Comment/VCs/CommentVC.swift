//
//  CommentTestVC.swift
//  BeMe
//
//  Created by 이재용 on 2021/01/06.
//

import UIKit

//MARK: - Comment 모델

struct CommentA {
    let comment: String
    let children: [CommentA]?
    var open: Bool
}
class CommentVC: UIViewController {
    
    @IBOutlet weak var commentTableView: UITableView!
    @IBOutlet weak var scrapButton: UIButton!
    
    lazy var popupBackgroundView: UIView = UIView()
    
    var pageNumber: Int?
    
    var isMoreButtonHidden: Bool?
    
    var isMyAnswer: Bool = false
    
    var isScrapped: Bool = false {
        didSet {
            
        }
    }
    
    private var commentArray: [CommentA] = [
        CommentA(comment: "안녕!", children: [CommentA(comment: "오! 안녕!", children: [], open: false),
                                                CommentA(comment: "오! 안녕!", children: [], open: false),
                                                CommentA(comment: "오! 안녕!", children: [], open: false)], open: false),
        CommentA(comment: "안녕!", children: [], open: false),
        CommentA(comment: "안녕!", children: [CommentA(comment: "오! 안녕!", children: [], open: false),
                                                CommentA(comment: "오! 안녕!", children: [], open: false)], open: false),
        CommentA(comment: "안녕!", children: [CommentA(comment: "오! 안녕!", children: [], open: false),
                                                CommentA(comment: "오! 안녕!", children: [], open: false),
                                                CommentA(comment: "오! 안녕!", children: [], open: false)], open: false),
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setPopupView()
        setCommentTableView()
        setNotificationCenter()
    }
    
    
    
    @IBAction func dismissButtonTapped(_ sender: UIButton) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func scrapButtonTapped(_ sender: UIButton) {
        
        if isScrapped {
            isScrapped = false
            scrapButton.setImage(UIImage(named: "btnScrapUnselected"), for: .normal)
        } else {
            isScrapped = true
            scrapButton.setImage(UIImage(named: "btnScrapSelected"), for: .normal)
        }
    }
    @IBAction func moreSettngButtonTapped(_ sender: Any) {
        popupBackgroundView.animatePopupBackground(true)
        guard let settingActionSheet = UIStoryboard.init(name: "CustomActionSheet", bundle: .main).instantiateViewController(withIdentifier: CustomActionSheet.identifier) as?
                CustomActionSheet else { return }
        
        settingActionSheet.modalPresentationStyle = .overCurrentContext
        self.present(settingActionSheet, animated: true, completion: nil)
    }
    
    
}

//MARK: - Private Method
extension CommentVC {
    
    private func setCommentTableView() {
        commentTableView.delegate = self
        commentTableView.dataSource = self
        commentTableView.estimatedRowHeight = 30
        commentTableView.rowHeight = UITableView.automaticDimension
    }
    
    private func setPopupView() {
        popupBackgroundView.setPopupBackgroundView(to: view)
    }
    
    private func setNotificationCenter() {
        NotificationCenter.default.addObserver(self, selector: #selector(closePopup), name: .init("closePopupNoti"), object: nil)
    }
    
    @objc func closePopup() {
        popupBackgroundView.animatePopupBackground(false)
    }
}

//MARK: - UITableViewDelegate

extension CommentVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return commentArray.count + 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1 // header
        } else {
            if commentArray[section-1].open {
                return commentArray[section-1].children!.count + 1
            } else {
                return 1
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            guard let header = tableView.dequeueReusableCell(withIdentifier: QuestionAnswerTVC.identifier, for: indexPath) as? QuestionAnswerTVC else { return UITableViewCell() }
            
            header.delegate = self
            header.indexPath = indexPath
            if let iMBH = isMoreButtonHidden {
                header.moreAnswerButton.isHidden = iMBH
            }
            header.profileView.isHidden = isMyAnswer
            return header
        } else {
            if indexPath.row == 0 {
                guard let comment = tableView.dequeueReusableCell(withIdentifier: CommentTVC.identifier, for: indexPath) as? CommentTVC else { return UITableViewCell() }
                
                comment.delegate = self
                comment.indexPath = indexPath
                if commentArray[indexPath.section-1].children!.count == 0 {
                    // 댓글 한개일 경우 "답글 보기" 없애는 로직 ******************고치기***********************
                    comment.moreCommentView.isHidden = true
                } else {
                    comment.moreCommentView.isHidden = false
                    if commentArray[indexPath.section-1].open {
                        comment.moreCommentLabel.text = "답글 접기"
                        comment.moreImageView.image = UIImage(named: "icArrowUp")
                        
                    } else {
                        comment.moreCommentLabel.text = "답글 보기"
                        comment.moreImageView.image = UIImage(named: "icArrowDown")
                    }
                }
                
                return comment
            } else {
                guard let secondComment = tableView.dequeueReusableCell(withIdentifier: SecondCommentTVC.identifier, for: indexPath) as? SecondCommentTVC else { return UITableViewCell() }
                
                return secondComment
            }
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableView.automaticDimension
        
    }
    
    
}

extension CommentVC: UITableViewButtonSelectedDelegate {
    
    func moreCellButtonDidTapped(to indexPath: IndexPath) {
        guard let cell = commentTableView.cellForRow(at: indexPath) as? CommentTVC else { return }
        guard let index = commentTableView.indexPath(for: cell) else { return }
        
        if indexPath.section == 0 {
            return
        } else {
            if indexPath.row == index.row {
                if indexPath.row == 0 {
                    if commentArray[index.section-1].open {
                        commentArray[index.section-1].open = false
                    } else {
                        commentArray[index.section-1].open = true
                    }
                    let section = IndexSet.init(integer: indexPath.section)
                    commentTableView.reloadSections(section, with: .fade)
                }
            }
        }
    }
    
    func moreAnswerButtonDidTapped(to indexPath: IndexPath) {
        
        
        
        guard let detailVC = UIStoryboard.init(name: "Explore", bundle: nil).instantiateViewController(identifier: "ExploreDetailVC") as? ExploreDetailVC else { return }
        self.dismiss(animated: true, completion: {
//            detailVC.modalPresentationStyle = .fullScreen
            guard let nowVC = self.presentingViewController else { return }
            
            print("nowVC")
            print(nowVC)
            nowVC.navigationController?.pushViewController(detailVC, animated: true)
        })
    }
}
