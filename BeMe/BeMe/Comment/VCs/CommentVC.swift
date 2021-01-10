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
    var children: [CommentA]?
    var open: Bool
}
class CommentVC: UIViewController {
    
    @IBOutlet weak var commentTableView: UITableView!
    @IBOutlet weak var scrapButton: UIButton!
    
    @IBOutlet weak var commentTextWrapper: UIView!
    @IBOutlet weak var commentBorderView: UIView!
    @IBOutlet weak var commentTextView: UITextView!
    @IBOutlet weak var lockButton: UIButton!
    @IBOutlet weak var commentSendButton: UIButton!
    @IBOutlet weak var commentTextWrapperBottomAnchor: NSLayoutConstraint!
    @IBOutlet weak var commentToCommentView: UIView!
    @IBOutlet weak var commentToCommentLabel: UILabel!
    
    lazy var popupBackgroundView: UIView = UIView()
    
    var answerId: Int?
    
    var pageNumber: Int?
    
    var isMoreButtonHidden: Bool?
    
    var isMyAnswer: Bool = false
    
    var isCommentToComment: Bool = false
    
    var selectedIndex: IndexPath?
    
    var isScrapped: Bool = false {
        didSet {
            
        }
    }
    
    var isCommentLocked: Bool = false
    
    private var answerDetail: AnswerDetail? {
        didSet {
            commentTableView.reloadData()
        }
    }
    
    private var realCommentArray: [Comment] = [] {
        didSet {
            realCommentArray.forEach { com in
                print(com)
                
            }
            commentTableView.reloadData()
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
    
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setPopupView()
        setCommentTableView()
        setNotificationCenter()
        setCommentView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        AnswerDetailService.shared.getAnswerDetail(answerId: answerId!) { (result) in
            switch result {
            case .success(let data):
                guard let dt = data as? GenericResponse<AnswerDetail> else { return }
                
                if let ad = dt.data {
                    self.answerDetail = ad
                    self.realCommentArray = ad.comment
                    
                }
                
                
            case .requestErr(let message):
                guard let message = message as? String else { return }
                let alertViewController = UIAlertController(title: "통신 실패", message: message, preferredStyle: .alert)
                let action = UIAlertAction(title: "확인", style: .cancel, handler: nil)
                alertViewController.addAction(action)
                self.present(alertViewController, animated: true, completion: nil)
                
            case .pathErr: print("path")
            case .serverErr:
                let alertViewController = UIAlertController(title: "통신 실패", message: "서버 오류", preferredStyle: .alert)
                let action = UIAlertAction(title: "확인", style: .cancel, handler: nil)
                alertViewController.addAction(action)
                self.present(alertViewController, animated: true, completion: nil)
                print("networkFail")
                print("serverErr")
            case .networkFail:
                let alertViewController = UIAlertController(title: "통신 실패", message: "네트워크 오류", preferredStyle: .alert)
                let action = UIAlertAction(title: "확인", style: .cancel, handler: nil)
                alertViewController.addAction(action)
                self.present(alertViewController, animated: true, completion: nil)
                print("networkFail")
            }
        }
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    
    @IBAction func dismissButtonTapped(_ sender: UIButton) {
        let text = commentTextView.text.trimmingCharacters(in: .whitespacesAndNewlines)
        if text.isEmpty || text == "댓글 달기" {
            self.dismiss(animated: true, completion: nil)
        } else {
            let alertVC = UIAlertController(title: "지금 뒤로가면 댓글이 삭제됩니다.\n뒤로 가시겠습니까?", message: "", preferredStyle: .alert)
            let cancel = UIAlertAction(title: "취소", style: .destructive, handler: {_ in
                
            })
            let ok = UIAlertAction(title: "삭제", style: .default, handler: {
                _ in
                self.dismiss(animated: true, completion: nil)
            })
            alertVC.addAction(cancel)
            alertVC.addAction(ok)
            self.present(alertVC, animated: true, completion: nil)
        }
        
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
        guard let settingActionSheet = UIStoryboard.init(name: "CustomActionSheet", bundle: .main).instantiateViewController(withIdentifier: CustomActionSheetVC.identifier) as?
                CustomActionSheetVC else { return }
        
        settingActionSheet.color = .black
        settingActionSheet.alertInformations = AlertLabels.article
        settingActionSheet.modalPresentationStyle = .overCurrentContext
        self.present(settingActionSheet, animated: true, completion: nil)
    }
    
    @IBAction func commentSendButtonTapped(_ sender: UIButton) {
        
        // 서버 통신
        
        if let comment = commentTextView.text {
            if isCommentToComment {
                
                if let selectedIndex = selectedIndex {
                    
                    commentArray[selectedIndex.section - 1].children?.append(CommentA(comment: comment, children: [], open: false))
                    
                    commentToCommentView.isHidden = true
                    
                    commentTableView.reloadData()
                    commentTableView.scrollToRow(at: selectedIndex, at: .bottom, animated: true)
                }
                
                
                isCommentToComment = false
            } else {
                commentArray.append(CommentA(comment: comment, children: [], open: false))
                
                commentTableView.reloadData()
                commentTableView.scrollToRow(at: IndexPath.init(row: 0, section: commentArray.endIndex), at: .bottom, animated: true)
            }
           
        }

        commentTextView.text = ""
        
        
    }
    
    @IBAction func cancelCoCButtonTapped(_ sender: UIButton) {
        
    }
    
    
    @IBAction func lockButtonTapped(_ sender: UIButton) {
        
        if isCommentLocked {
            isCommentLocked = false
            lockButton.setImage(UIImage.init(named: "btnUnlock"), for: .normal)
        } else {
            isCommentLocked = true
            lockButton.setImage(UIImage.init(named: "btnLockBlack"), for: .normal)
        }
        
    }
}

//MARK: - Private Method
extension CommentVC {
    
    private func setCommentView() {
        commentBorderView.setBorderWithRadius(borderColor: UIColor.Border.textView, borderWidth: 1.0, cornerRadius: 6.0)
        commentTextView.text = "댓글 달기"
        commentTextView.textColor = UIColor.lightGray
        
        
    }
    private func setCommentTableView() {
        commentTableView.delegate = self
        commentTableView.dataSource = self
        commentTableView.estimatedRowHeight = 30
        commentTableView.rowHeight = UITableView.automaticDimension
        commentTableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 166, right: 0)
        commentTableView.keyboardDismissMode = .onDrag
    }
    
    private func setPopupView() {
        popupBackgroundView.setPopupBackgroundView(to: view)
    }
    
    private func setNotificationCenter() {
        NotificationCenter.default.addObserver(self, selector: #selector(closePopup), name: .init("closePopupNoti"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func closePopup() {
        popupBackgroundView.animatePopupBackground(false)
    }
    
    
    @objc func keyboardWillShow(_ sender: Notification) {
        handleKeyboardIssue(sender, isAppearing: true)
    }
    
    @objc func keyboardWillHide(_ sender: Notification) {
        handleKeyboardIssue(sender, isAppearing: false)
    }
    
    private func handleKeyboardIssue(_ notification: Notification, isAppearing: Bool) {
        guard let userInfo = notification.userInfo as? [String: Any] else { return }
        guard let keyboardAnimationDuration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval else { return }
        guard let keyboardHeight = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.height else { return }
        
        // 기기별 bottom safearea 계산하기
        let heightConstant = isAppearing ? keyboardHeight - 34 : 0
        
        UIView.animate(withDuration: keyboardAnimationDuration, animations: {
            self.commentTextWrapperBottomAnchor.constant = heightConstant
            self.view.layoutIfNeeded()
        }) { (_) in
        }
        
        if isAppearing {
            let inset = UIEdgeInsets(top: 0, left: 0, bottom: 61 + keyboardHeight, right: 0)
            commentTableView.contentInset = inset
            commentTableView.setContentInsetAndScrollIndicatorInsets(inset)
        } else {
            let inset = UIEdgeInsets(top: 0, left: 0, bottom: 166, right: 0)
            commentTableView.contentInset = inset
            commentTableView.setContentInsetAndScrollIndicatorInsets(inset)
        }
        
        print(commentTextWrapperBottomAnchor.constant)
    }
}

//MARK: - UITableViewDelegate

extension CommentVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return realCommentArray.count + 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1 // header
        } else {
            if realCommentArray[section-1].open {
                return realCommentArray[section-1].children.count + 1
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
            if let ad = answerDetail {
                header.setInformation(question: ad.question, category: ad.category , date: ad.answerDate,
                                      profileImg: ad.userProfile, nickName: ad.userNickname, content: ad.content)
            }
            
            return header
        } else {
            if indexPath.row == 0 {
                print("비공개 공개")
                print(realCommentArray[indexPath.section-1].isVisible)
                if realCommentArray[indexPath.section-1].isVisible {
                    
                    guard let comment = tableView.dequeueReusableCell(withIdentifier: CommentTVC.identifier,
                                                                      for: indexPath) as? CommentTVC else {
                        return UITableViewCell() }
                    
                    comment.delegate = self
                    comment.indexPath = indexPath
                    
                    if realCommentArray[indexPath.section-1].children.count == 0 {
                        
                        comment.moreCommentView.isHidden = true
                    } else {
                        comment.moreCommentView.isHidden = false
                        if realCommentArray[indexPath.section-1].open {
                            comment.moreCommentLabel.text = "답글 접기"
                            comment.moreImageView.image = UIImage(named: "icArrowUp")
                            
                        } else {
                            comment.moreCommentLabel.text = "답글 보기"
                            comment.moreImageView.image = UIImage(named: "icArrowDown")
                        }
                    }
                    
                    comment.setInformations(profileImage: realCommentArray[indexPath.row].profileImg, nickName: realCommentArray[indexPath.row].userNickname, publicFlag: realCommentArray[indexPath.row].publicFlag, isVisible: realCommentArray[indexPath.row].isVisible, content: realCommentArray[indexPath.row].content, date: realCommentArray[indexPath.row].createdAt)
                    
                    return comment
                } else {
                    guard let secret = tableView.dequeueReusableCell(withIdentifier: SecretTVC.identifier, for: indexPath) as? SecretTVC else { return UITableViewCell() }
                    

                    secret.delegate = self
                    secret.indexPath = indexPath
                    if realCommentArray[indexPath.section-1].children.count == 0{
                        secret.moreCommentView.isHidden = true
                    } else {
                        secret.moreCommentView.isHidden = false
                        if realCommentArray[indexPath.section-1].open {
                            secret.moreCommentLabel.text = "답글 접기"
                            secret.moreImageView.image = UIImage(named: "icArrowUp")
                            
                        } else {
                            secret.moreCommentLabel.text = "답글 보기"
                            secret.moreImageView.image = UIImage(named: "icArrowDown")
                        }
                    }
                    
                    return secret
                }
            } else {
                
                guard let secondComment = tableView.dequeueReusableCell(withIdentifier: SecondCommentTVC.identifier, for: indexPath) as? SecondCommentTVC else { return UITableViewCell() }
 
                
                secondComment.setInformation(profileImage: realCommentArray[indexPath.section-1].children[indexPath.row-1].profileImg, nickName: realCommentArray[indexPath.section-1].children[indexPath.row-1].userNickname, content: realCommentArray[indexPath.section-1].children[indexPath.row-1].content, date: realCommentArray[indexPath.section-1].children[indexPath.row-1].createdAt, isVisible: realCommentArray[indexPath.section-1].children[indexPath.row-1].isVisible, publicFlag: realCommentArray[indexPath.section-1].children[indexPath.row-1].publicFlag)
                
                
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
        
        print("first")
        guard let cell = commentTableView.cellForRow(at: indexPath) as? SecretTVC else { return }
        print("second")
        guard let index = commentTableView.indexPath(for: cell) else { return }
        
        print(index)
        print("moreCellButtonDidTapped")
        if indexPath.section == 0 {
            return
        } else {
            if indexPath.row == index.row {
                if indexPath.row == 0 {
                    if realCommentArray[index.section-1].open {
                        realCommentArray[index.section-1].open = false
                    } else {
                        realCommentArray[index.section-1].open = true
                    }
                    // 애니메이션 삭제
//                    let section = IndexSet.init(integer: indexPath.section)
//                    commentTableView.reloadSections(section, with: .fade)
                }
            }
        }
    }
    
    func sendCommentButtonDidTapped(to indexPath: IndexPath) {
        
        commentTextView.becomeFirstResponder()
        commentTableView.scrollToRow(at: indexPath, at: .middle, animated: true)
        commentToCommentView.isHidden = false
        selectedIndex = indexPath
        isCommentToComment = true
        
    }
    
    
    func settingButtonDidTapped(to indexPath: IndexPath) {
        
        popupBackgroundView.animatePopupBackground(true)
        guard let settingActionSheet = UIStoryboard.init(name: "CustomActionSheet", bundle: nil).instantiateViewController(identifier: CustomActionSheetVC.identifier) as? CustomActionSheetVC else { return }
        settingActionSheet.color = .red
        settingActionSheet.alertInformations = AlertLabels.otherCommentMyArticle
        self.present(settingActionSheet, animated: true, completion: nil)
    }
}

//MARK: - TextField

extension CommentVC: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        if textView == commentTextView {
            
            // 완료버튼 처리
            let text = textView.text.trimmingCharacters(in: .whitespacesAndNewlines)
            commentSendButton.isHidden = text.isEmpty
            
            // max 5줄 설정
//            let line = Int(textView.contentSize.height / textView.font!.lineHeight )
//
//
//            if line <= 5 {
//                textView.isScrollEnabled = false
//            } else {
//                textView.isScrollEnabled = true
//            }
            
        }
    }
    
    // TextView Place Holder
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
        
    }
    // TextView Place Holder
    func textViewDidEndEditing(_ textView: UITextView) {
        let text = textView.text.trimmingCharacters(in: .whitespacesAndNewlines)
        if text.isEmpty {
            textView.text = "댓글 달기"
            textView.textColor = UIColor.lightGray
        }
    }
}

