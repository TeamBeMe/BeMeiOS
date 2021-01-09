//
//  ExploreDetailVC.swift
//  BeMe
//
//  Created by 이재용 on 2021/01/02.
//

import UIKit

class ExploreDetailVC: UIViewController {
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var highLightBar: UIView!
    @IBOutlet weak var diffAnswerTableView: UITableView!
    
    private var cellNumber: Int = 10
    
    private var lastContentOffset: CGFloat = 0.0
    
    private var scrollDirection: Bool = false
    
    private var currentPage: Int = 1
    
    private var page: Int = 1
    
    private var sorting: String = "최신"
    
    var questionText: String?
    
    var questionId: Int?
    
    lazy var popupBackgroundView: UIView = UIView()
    
    private var exploreAnswerArray: [ExploreAnswer] = [] {
        didSet {
            diffAnswerTableView.reloadData()
        }
    }
    
    
    //MARK: - Life Cycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setAnswerData()
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.navigationBar.isHidden = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setPopupBackgroundView()
        setNotificationCenter()
        setTableView()
        setQuestion(question: questionText!)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func setQuestion(question: String) {
        questionLabel.text = question
    }
    
    //MARK: - IBAction
    
    @IBAction func backButtonTapped(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func recentButtonTapped(_ sender: UIButton) {
        moveHighLightBar(to: sender)
        sorting = "최신"
        setAnswerData()
    }
    
    @IBAction func favoriteButtonTapped(_ sender: UIButton) {
        moveHighLightBar(to: sender)
        sorting = "흥미"
        setAnswerData()
    }
}

//MARK: - Private Method
extension ExploreDetailVC {
    
    private func setAnswerData() {
        
        ExploreDetailAnswerService.shared.getExploreDetailAnswer(questionId: questionId!, page: currentPage, sorting: sorting) { (result) in
            switch result {
            case .success(let data):
                guard let dt = data as? GenericResponse<ExploreAnswerData> else { return }
                if let dat = dt.data {
                    self.page = dat.pageLen
                    if let ans = dat.answers {
                        self.exploreAnswerArray = ans
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
    
    private func moveHighLightBar(to button: UIButton) {
        
        UIView.animate(withDuration: 0.33, delay: 0, options: [.curveLinear], animations: {
            // Slide Animation
            self.highLightBar.frame.origin.x = 30 + button.frame.minX
        }) { _ in
        }
    }
    
    private func setTableView() {
        diffAnswerTableView.contentInset = UIEdgeInsets(top: 18, left: 0, bottom: 119, right: 0)
    }
    
    private func setPopupBackgroundView() {
        popupBackgroundView.setPopupBackgroundView(to: view)
    }
    
    private func setNotificationCenter() {
        NotificationCenter.default.addObserver(self, selector: #selector(closePopup), name: .init("closePopupNoti"), object: nil)
    }
    
    @objc func closePopup() {
        popupBackgroundView.animatePopupBackground(false)
    }
}


extension ExploreDetailVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if currentPage < page {
            return 10 + 1
        } else {
            return exploreAnswerArray.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if currentPage < page {
            if indexPath.row == 11 - 1 {
                guard let more = tableView.dequeueReusableCell(withIdentifier: DetailMoreTVC.identifier,
                                                               for: indexPath) as? DetailMoreTVC else {
                    return UITableViewCell() }
                return more
            } else {
                guard let answer = tableView.dequeueReusableCell(withIdentifier: AnswerTVC.identifier,
                                                                 for: indexPath) as? AnswerTVC else {
                    return UITableViewCell() }
                
                answer.delegate = self
                answer.indexPath = indexPath
                answer.setCardDatas(date: exploreAnswerArray[indexPath.row].answerDate, cate: exploreAnswerArray[indexPath.row].category, content: exploreAnswerArray[indexPath.row].content, profileImage: exploreAnswerArray[indexPath.row].userProfile, nick: exploreAnswerArray[indexPath.row].userNickname, isScrap: exploreAnswerArray[indexPath.row].isScrapped, answerId: exploreAnswerArray[indexPath.row].id, questionId: exploreAnswerArray[indexPath.row].questionID)
                
                return answer
            }
        } else {
            guard let answer = tableView.dequeueReusableCell(withIdentifier: AnswerTVC.identifier,
                                                             for: indexPath) as? AnswerTVC else {
                return UITableViewCell() }
            
            answer.delegate = self
            answer.indexPath = indexPath
            answer.setCardDatas(date: exploreAnswerArray[indexPath.row].answerDate, cate: exploreAnswerArray[indexPath.row].category, content: exploreAnswerArray[indexPath.row].content, profileImage: exploreAnswerArray[indexPath.row].userProfile, nick: exploreAnswerArray[indexPath.row].userNickname, isScrap: exploreAnswerArray[indexPath.row].isScrapped, answerId: exploreAnswerArray[indexPath.row].id, questionId: exploreAnswerArray[indexPath.row].questionID)
            
            
            return answer
        }
    }
   
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if currentPage < page {
            if indexPath.row == 11 - 1 {
                // animation 2
                cell.alpha = 0
                UIView.animate(withDuration: 0.75) {
                    
                    cell.alpha = 1.0
                }
            } else {
                // animation 1
                if (scrollDirection) {
                    // up
                    let rotationTransform = CATransform3DTranslate(CATransform3DIdentity, 0, 50, 0)
                    cell.layer.transform = rotationTransform
                    UIView.animate(withDuration: 0.3, delay: 0, options: [.curveEaseInOut], animations: {
                        cell.layer.transform = CATransform3DIdentity
                    }) { (_) in
                        
                    }
                } else {
                    // down
                    let rotationTransform = CATransform3DTranslate(CATransform3DIdentity, 0, -50, 0)
                    cell.layer.transform = rotationTransform
                    UIView.animate(withDuration: 0.3, animations: {
                        cell.layer.transform = CATransform3DIdentity
                    })
                }
            }
        } else {
            // animation 1
            if (scrollDirection) {
                // up
                let rotationTransform = CATransform3DTranslate(CATransform3DIdentity, 0, 50, 0)
                cell.layer.transform = rotationTransform
                UIView.animate(withDuration: 0.3, delay: 0, options: [.curveEaseInOut], animations: {
                    cell.layer.transform = CATransform3DIdentity
                }) { (_) in
                    
                }
            } else {
                // down
                let rotationTransform = CATransform3DTranslate(CATransform3DIdentity, 0, -50, 0)
                cell.layer.transform = rotationTransform
                UIView.animate(withDuration: 0.3, animations: {
                    cell.layer.transform = CATransform3DIdentity
                })
            }
        }
    }
    
    func scrollViewDidScroll (_ scrollView: UIScrollView) {
        let currentContentOffset = scrollView.contentOffset.y
        
        if (currentContentOffset > lastContentOffset) {
            // scroll up
            scrollDirection = true
        } else {
            // scroll down
            scrollDirection = false
        }
        lastContentOffset = currentContentOffset
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
//        guard let comment = UIStoryboard.init(name: "Comment", bundle: nil).instantiateViewController(identifier: "CommentVC") as? CommentVC else { return }
//
//        //        comment.
//        comment.isMoreButtonHidden = true
//        comment.modalPresentationStyle = .fullScreen
//        self.present(comment, animated: true, completion: nil)
    }
}


//MARK: - UITableViewButtonSelectedDelegate
extension ExploreDetailVC: UITableViewButtonSelectedDelegate {
    
    func settingButtonDidTapped(to indexPath: IndexPath) {
        
        popupBackgroundView.animatePopupBackground(true)
        
        guard let settingActionSheet = UIStoryboard.init(name: "CustomActionSheet", bundle: .main).instantiateViewController(withIdentifier: CustomActionSheetVC.identifier) as?
                CustomActionSheetVC else { return }
        
        settingActionSheet.alertInformations = AlertLabels.article
        settingActionSheet.modalPresentationStyle = .overCurrentContext
        self.present(settingActionSheet, animated: true, completion: nil)
    }
}
