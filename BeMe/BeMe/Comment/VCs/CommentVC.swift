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
    
    // 대댓글달기
    var isCommentToComment: Bool = false
    var parentId: Int?
    var selectedIndex: IndexPath?
    
    // 댓글에 대한 더보기 설정을 위한 변수들
    var selectedCommentId: Int?
    var selectedCommentContent: String?
    var isEditingComment: Bool = false
    var selectedIndexPath: IndexPath?
    
    // 댓글 공개 유무 default
    private var isPublic: Bool = true
    private var isScrapped: Bool = false {
        didSet {
            
        }
    }
    
    private var answerDetail: AnswerDetail? {
        didSet {
            commentTableView.reloadData()
        }
    }
    
    private var realCommentArray: [Comment] = [] {
        didSet {
            commentTableView.reloadData()
        }
    }
    
    
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
        
        self.navigationController?.navigationBar.isHidden = true
        getAnswerDetail()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    
    //MARK: - IBAction Method
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
        scrapAnswer(answerId: answerId!)
    }
    
    @IBAction func moreSettngButtonTapped(_ sender: Any) {
        popupBackgroundView.animatePopupBackground(true)
        guard let settingActionSheet = UIStoryboard.init(name: "CustomActionSheet", bundle: .main).instantiateViewController(withIdentifier: CustomActionSheetOneVC.identifier) as?
                CustomActionSheetOneVC else { return }
        
        settingActionSheet.modalPresentationStyle = .overCurrentContext
        
        self.present(settingActionSheet, animated: true, completion: nil)
    }
    
    @IBAction func commentSendButtonTapped(_ sender: UIButton) {
        
        // 서버 통신
        if let comment = commentTextView.text {
            if isEditingComment {
                editComment()
                isEditingComment = false
            } else {
                if isCommentToComment {
                    
                    if let selectedIndex = selectedIndex {
                        sendComment(content: comment, parentId: parentId)
                        
                        
                        commentTableView.reloadData()
                        commentTableView.scrollToRow(at: selectedIndex, at: .bottom, animated: true)
                    }
                    isCommentToComment = false
                } else {
                    sendComment(content: comment, parentId: nil)
                }
            }
            
        }

        commentTextView.text = ""
        
        
    }
    
    @IBAction func cancelCoCButtonTapped(_ sender: UIButton) {
        
        commentToCommentView.isHidden = true
        isCommentToComment = false
    }
    
    
    @IBAction func lockButtonTapped(_ sender: UIButton) {
        
        if isEditingComment {
            showToast(message: "댓글 공개범위는 수정이 불가능합니다.", font: UIFont(name: "AppleSDGothicNeo-Medium", size: 14.0) ?? UIFont.systemFont(ofSize: 14.0))
        } else {
            if isPublic {
                isPublic = false
                lockButton.setImage(UIImage.init(named: "btnLockBlack"), for: .normal)
            } else {
                isPublic = true
                lockButton.setImage(UIImage.init(named: "btnUnlock"), for: .normal)
            }

        }
                
    }
}

//MARK: - Private Method
extension CommentVC {
    
    private func scrapAnswer(answerId: Int) {
        
        ExploreAnswerScrapService.shared.putExploreAnswerScrap(answerId: answerId) { (result) in
            switch result {
            case .success(let data):
                guard let dt = data as? GenericResponse<Int> else { return }
                print(dt.message)
                if dt.message == "스크랩 성공" {
                    // 사용자한테 성공했다고 알려주는 동작
                    self.scrapButton.setImage(UIImage(named: "btnScrapSelected"), for: .normal)
                } else if dt.message == "스크랩 취소 성공" {
                    // 사용자한테 스크랩 취소 성공했다고 알려주는 동작
                    self.scrapButton.setImage(UIImage(named: "btnScrapUnselected"), for: .normal)
                } else {
                    // 사용자한테 실패했다고 알려주는 동작
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
    
    private func showToast(message : String, font: UIFont = UIFont.systemFont(ofSize: 14.0)) {
        let toastLabel = UILabel()
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.font = font
        toastLabel.textAlignment = .center
        toastLabel.text = message
        
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds = true
        
        self.view.addSubview(toastLabel)
        
        toastLabel.translatesAutoresizingMaskIntoConstraints = false
        toastLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 15.0).isActive = true
        toastLabel.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -15.0).isActive = true
        toastLabel.bottomAnchor.constraint(equalTo: commentTextWrapper.topAnchor, constant: -15.0).isActive = true
        toastLabel.heightAnchor.constraint(equalToConstant: 52.0).isActive = true
        
        UIView.animate(withDuration: 2.0, delay: 0.1, options: .curveEaseOut, animations: {
                        toastLabel.alpha = 0.0
            
        }, completion: {
                            (isCompleted) in toastLabel.removeFromSuperview()
                            
                        })
    }
    
    private func sendComment(content: String, parentId: Int?) {
        CommentService.shared.postComment(answerId: answerId!, content: content, parentId: parentId,
                                          isPublic: isPublic) { (result) in
            switch result {
            case .success(let data):
                guard let dt = data as? GenericResponse<Comment> else { return }
                print(dt)
                if let co = dt.data {
                    print(co)
                    let newComment: Comment = co
                    
                    if newComment.parentID == -1 {
                        self.realCommentArray.append(newComment)
                        self.commentTableView.scrollToRow(at: IndexPath.init(row: 0, section: self.realCommentArray.endIndex), at: .bottom, animated: true)
                        
                    } else {
                        self.realCommentArray[self.selectedIndex!.section-1].children.append(newComment)
                        self.commentToCommentView.isHidden = true
                        
                    }
                
                    
                    
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
    
    private func getAnswerDetail() {
        
        AnswerDetailService.shared.getAnswerDetail(answerId: answerId!) { (result) in
            switch result {
            case .success(let data):
                guard let dt = data as? GenericResponse<AnswerDetail> else { return }
                
                if let ad = dt.data {
                    self.answerDetail = ad
                    self.realCommentArray = ad.comment
                    
                    // 댓글 막을지 말지
                    if ad.commentBlockedFlag {
                        self.commentTextWrapper.isHidden = true
                    } else {
                        self.commentTextWrapper.isHidden = false
                    }
                    
                    // 스크랩 유무
                    if ad.isScrapped {
                        self.scrapButton.setImage(UIImage.init(named: "btnScrapSelected"), for: .normal)
                    } else {
                        self.scrapButton.setImage(UIImage.init(named: "btnScrapUnselected"), for: .normal)
                    }
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

    private func editComment() {
        CommentService.shared.putComment(commentId: selectedCommentId!, content: commentTextView.text!) {
            (result) in
            switch result {
            case .success(let data):
                guard let _ = data as? GenericResponse<Comment> else { return }

                self.commentTableView.scrollToRow(at: self.selectedIndexPath!, at: .middle, animated: true)
                self.getAnswerDetail()
                
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
    
    private func deleteComment() {
        CommentService.shared.deleteComment(commentId: selectedCommentId!) { (result) in
            switch result {
            case .success(let data):
                guard let _ = data as? GenericResponse<Comment> else { return }

                self.getAnswerDetail()
                self.showToast(message: "댓글이 삭제되었습니다.", font: UIFont(name: "AppleSDGothicNeo-Medium", size: 14.0) ?? UIFont.systemFont(ofSize: 14.0))
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
    
    private func setCommentView() {
        commentBorderView.setBorderWithRadius(borderColor: UIColor.Border.textView, borderWidth: 1.0, cornerRadius: 6.0)
        commentTextView.text = "댓글 달기"
        commentTextView.textColor = UIColor.lightGray
        commentToCommentView.isHidden = true
        
    }
    private func setCommentTableView() {
        commentTableView.delegate = self
        commentTableView.dataSource = self
        commentTableView.estimatedRowHeight = 30
        commentTableView.rowHeight = UITableView.automaticDimension
        commentTableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 166, right: 0)
        commentTableView.keyboardDismissMode = .interactive
    }
    
    private func setPopupView() {
        popupBackgroundView.setPopupBackgroundView(to: view)
    }
    
    private func setNotificationCenter() {
        NotificationCenter.default.addObserver(self, selector: #selector(closePopup), name: .init("closePopupNoti"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func closePopup(_ notification: Notification) {
        popupBackgroundView.animatePopupBackground(false)
        guard let userInfo = notification.userInfo as? [String:Any] else { return }
        guard let action = userInfo["action"] as? String else { return }
        
        if action == "commentPut" {
            
            isEditingComment = true
            commentTextView.textColor = .black
            commentTextView.text = selectedCommentContent
            commentTextView.becomeFirstResponder()
            commentTableView.scrollToRow(at: selectedIndexPath!, at: .middle, animated: true)
            
        } else if action == "report" {
            // 메일 띄우기
        } else if action == "commentDelete" {
            
            deleteComment()
            
        } else if action == "block" {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.21) {
                
                let alertViewController = UIAlertController(title: "업데이트 될 예정입니다.", message: "다음 업데이트를 기다려주세요🥰", preferredStyle: .alert)
                let action = UIAlertAction(title: "확인", style: .cancel, handler: nil)
                alertViewController.addAction(action)
                self.present(alertViewController, animated: true, completion: nil)
            }

        }
        
        print(action)
    }
    
//    private func
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
            
            guard let header = tableView.dequeueReusableCell(withIdentifier: QuestionAnswerTVC.identifier,
                                                             for: indexPath) as? QuestionAnswerTVC else {
                return UITableViewCell() }
            
            header.delegate = self
            header.indexPath = indexPath
            if let iMBH = isMoreButtonHidden {
                header.moreAnswerButton.isHidden = iMBH
            }
            
            header.profileView.isHidden = answerDetail?.isAuthor ?? true
            if let ad = answerDetail {
                header.setInformation(question: ad.question, category: ad.category , date: ad.answerDate,
                                      profileImg: ad.userProfile, nickName: ad.userNickname,
                                      content: ad.content, questionId: ad.questionID)
            }
            
            return header
        } else {
            if indexPath.row == 0 {
               
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
                    
//                    print(realCommentArray[indexPath.section-1].publicFlag)
                    comment.setInformations(profileImage: realCommentArray[indexPath.section-1].profileImg, nickName: realCommentArray[indexPath.section-1].userNickname, publicFlag: realCommentArray[indexPath.section-1].publicFlag, isVisible: realCommentArray[indexPath.section-1].isVisible, content: realCommentArray[indexPath.section-1].content, date: realCommentArray[indexPath.section-1].createdAt, commentId: realCommentArray[indexPath.section-1].id, isAuthor: realCommentArray[indexPath.section-1].isAuthor)
                    
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
 
                secondComment.delegate = self
                secondComment.indexPath = indexPath

                secondComment.setInformation(profileImage: realCommentArray[indexPath.section-1].children[indexPath.row-1].profileImg, nickName: realCommentArray[indexPath.section-1].children[indexPath.row-1].userNickname, content: realCommentArray[indexPath.section-1].children[indexPath.row-1].content, date: realCommentArray[indexPath.section-1].children[indexPath.row-1].createdAt, isVisible: realCommentArray[indexPath.section-1].children[indexPath.row-1].isVisible, publicFlag: realCommentArray[indexPath.section-1].children[indexPath.row-1].publicFlag, isAuthor: realCommentArray[indexPath.section-1].children[indexPath.row-1].isAuthor, commentId: realCommentArray[indexPath.section-1].children[indexPath.row-1].id)
                
                
                return secondComment
 
            }
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableView.automaticDimension
        
    }
    
    
}

extension CommentVC: UITableViewButtonSelectedDelegate {
    
    func goToMoreAnswerButtonDidTapped(questionId: Int, question: String) {
        let sb = UIStoryboard.init(name: "Explore", bundle: nil)
        guard let detail = sb.instantiateViewController(identifier: "ExploreDetailVC") as?
                ExploreDetailVC else { return }
        detail.questionId = questionId
        detail.questionText = question
        self.navigationController?.pushViewController(detail, animated: true)
    }
    
    func moreCellButtonDidTapped(to indexPath: IndexPath, isSecret: Int) {
        if isSecret == 0 {
            guard let cell = commentTableView.cellForRow(at: indexPath) as? CommentTVC else { return }
            guard let index = commentTableView.indexPath(for: cell) else { return }
            
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
        } else {
            guard let cell = commentTableView.cellForRow(at: indexPath) as? SecretTVC else { return }
            
            guard let index = commentTableView.indexPath(for: cell) else { return }
            
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
        
    }
    
    func sendCommentButtonDidTapped(to indexPath: IndexPath, nickName: String, parentId: Int) {
        
        commentTextView.becomeFirstResponder()
        commentTableView.scrollToRow(at: indexPath, at: .middle, animated: true)
        commentToCommentLabel.text = "\(nickName)님에게 답글을 남기는 중"
        commentToCommentView.isHidden = false
        
        selectedIndex = indexPath
        self.parentId = parentId
        isCommentToComment = true
        
    }
    
    
    func settingButtonDidTapped(to indexPath: IndexPath, isAuthor: Bool, commentId: Int, content: String) {
        
        popupBackgroundView.animatePopupBackground(true)
        
        if isAuthor {
            guard let settingActionSheet = UIStoryboard.init(name: "CustomActionSheet", bundle: nil).instantiateViewController(withIdentifier: CustomActionSheetTwoVC.identifier) as?
                    CustomActionSheetTwoVC else { return }
        
            settingActionSheet.alertInformations = AlertLabels.myComment
            settingActionSheet.isOnlySecondTextColored = true
            settingActionSheet.secondColor = UIColor.init(named: "grapefruit")
            settingActionSheet.modalPresentationStyle = .overCurrentContext
        
            selectedIndexPath = indexPath
            selectedCommentId = commentId
            selectedCommentContent = content
            self.present(settingActionSheet, animated: true, completion: nil)
        } else {
            if answerDetail!.isAuthor {
                guard let settingActionSheet = UIStoryboard.init(name: "CustomActionSheet", bundle: nil).instantiateViewController(withIdentifier: CustomActionSheetTwoVC.identifier) as?
                        CustomActionSheetTwoVC else { return }
            
                settingActionSheet.alertInformations = AlertLabels.otherCommentMyArticleNoBlock
                settingActionSheet.color = .grapefruit
                settingActionSheet.modalPresentationStyle = .overCurrentContext
            
                selectedIndexPath = indexPath
                selectedCommentId = commentId
                selectedCommentContent = content
                
                self.present(settingActionSheet, animated: true, completion: nil)
            } else {
                guard let settingActionSheet = UIStoryboard.init(name: "CustomActionSheet", bundle: nil).instantiateViewController(withIdentifier: CustomActionSheetOneVC.identifier) as?
                        CustomActionSheetOneVC else { return }
                
//                settingActionSheet.alertInformations = AlertLabels.otherCommentNotMyArticle
//                settingActionSheet.color = .grapefruit
                settingActionSheet.modalPresentationStyle = .overCurrentContext
            
                selectedIndexPath = indexPath
                selectedCommentId = commentId
                selectedCommentContent = content
                
                self.present(settingActionSheet, animated: true, completion: nil)
            }
        }
        
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

