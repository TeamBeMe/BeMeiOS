//
//  ExploreHomeVC.swift
//  BeMe
//
//  Created by 이재용 on 2021/01/08.
//

import UIKit

class ExploreTableView: UITableView {
    
    private var reloadDataCompletionBlock: (() -> Void)?
    
    
    func reloadDataWithCompletion(_ complete: @escaping () -> Void) {
        reloadDataCompletionBlock = complete
        super.reloadData()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if let block = reloadDataCompletionBlock {
            block()
        }
    }
}

class ExploreHomeVC: UIViewController {
    
    @IBOutlet weak var exploreTableView: ExploreTableView!
    @IBOutlet weak var safeAreaView: UIView!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var headerViewHeight: NSLayoutConstraint!
    @IBOutlet weak var headerCategoryCollectionView: UICollectionView!
    @IBOutlet weak var headerHighLightBar: UIView!
    private var lastContentOffset: CGFloat = 0
    
    private let maxHeight: CGFloat = 32.0
    
    private let minHeight: CGFloat = 0.0
    
    private let headerFrameOriginY: CGFloat = 56.0
    
    private var scrollDirection: Bool = true
    
    private var page: Int = 1
    
    private var currentPage: Int = 1
    
    private var selectedCategoryId: Int = 0
    
    private var selectedRecentOrFavorite: String = "최신"
    
    private var isTableViewAnimation: Bool = false
    
    private var currentPageAlreadyGetContainers: [Int] = []
    
    // 서버통신을 통해 받아오는 값
    private var categoryArray: [ExploreCategory] = [] {
        didSet {
            //            exploreTableView.reloadData()
        }
    }
    
    private var exploreThoughtArray: [ExploreThoughtData] = [] {
        didSet {
            //            exploreTableView.reloadData()
        }
    }
    
    private var exploreAnswerArray: [ExploreAnswer] = [] {
        didSet {
            exploreTableView.reloadDataWithCompletion {
                LoadingHUD.hide()
            }
        }
    }
    
    //MARK: - life cylce
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableView()
        self.navigationController?.interactivePopGestureRecognizer?.delegate = nil
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        LoadingHUD.show(loadingFrame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height), color: UIColor(named: "background")!)
        setAnswerData(page: currentPage, category: selectedCategoryId, sorting: selectedRecentOrFavorite)
        setThoughtData()
        setCategoryData()
        setHeaderView()
        
        
        view.backgroundColor = lastContentOffset > 394.0 ? .white : UIColor.init(named: "background")
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.navigationController?.navigationBar.isHidden = false
    }
    
    
    
    
    
    
    
    @IBAction func recentButtonTapped(_ sender: Any) {
        moveHighLightBar(to: sender as! UIButton)
        
        isTableViewAnimation = false
        scrollDirection = true
        selectedRecentOrFavorite = "최신"
        selectedCategoryId = 0
        currentPage = 1
        currentPageAlreadyGetContainers.removeAll()
        setAnswerData(page: currentPage, category: selectedCategoryId , sorting: selectedRecentOrFavorite)
    }
    
    @IBAction func favoriteButtonTapped(_ sender: Any) {
        moveHighLightBar(to: sender as! UIButton)
        
        isTableViewAnimation = false
        scrollDirection = true
        selectedRecentOrFavorite = "흥미"
        selectedCategoryId = 0
        currentPage = 1
        currentPageAlreadyGetContainers.removeAll()
        setAnswerData(page: currentPage, category: selectedCategoryId , sorting: selectedRecentOrFavorite)
    }
    
    private func moveHighLightBar(to button: UIButton) {
        
        UIView.animate(withDuration: 0.3, delay: 0, options: [.curveLinear], animations: {
            // Slide Animation
            self.headerHighLightBar.frame.origin.x = 30 + button.frame.minX
            
        }) { _ in
        }
    }
}

//MARK: - CollectionView
//extension ExploreHomeVC: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

//}

//MARK: - UITableView
extension ExploreHomeVC: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else if section == 1 {
            return 1
        } else {
            if exploreAnswerArray.count == 0 {
                return 1
            } else {
                if currentPage < page {
                    return exploreAnswerArray.count + 1
                } else {
                    return exploreAnswerArray.count
                }
//                return exploreAnswerArray.count
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let diffThought = tableView.dequeueReusableCell(withIdentifier: DiffThoughtTVC.identifier, for: indexPath) as? DiffThoughtTVC else { return UITableViewCell() }
            
            if exploreThoughtArray.count == 0 {
                diffThought.isEmpty = true
            } else {
                diffThought.isEmpty = false
            }
            
            diffThought.delegate = self
            diffThought.exploreThoughtArray = self.exploreThoughtArray
            return diffThought
        } else if indexPath.section == 1 {
            guard let diffAnswer = tableView.dequeueReusableCell(withIdentifier: DiffArticleTVC.identifier, for: indexPath) as? DiffArticleTVC else { return UITableViewCell() }
            
            diffAnswer.selectedCategoryId = self.selectedCategoryId
            diffAnswer.categoryArray = self.categoryArray
            diffAnswer.delegate = self
            return diffAnswer
        } else {
            if exploreAnswerArray.count == 0 {
                guard let emptyArticle = tableView.dequeueReusableCell(withIdentifier: EmptyArticleTVC.identifier, for: indexPath) as? EmptyArticleTVC else { return UITableViewCell() }
                
                return emptyArticle
            } else {
                if currentPage < page {
                    if indexPath.row == exploreAnswerArray.count {
                        // 더보기 버튼
                        guard let more = tableView.dequeueReusableCell(withIdentifier: MoreTVC.identifier, for: indexPath) as? MoreTVC else { return UITableViewCell() }
                        more.delegate = self
                        return more
                    } else {
                        guard let answer = tableView.dequeueReusableCell(withIdentifier: ArticleTVC.identifier, for: indexPath)  as? ArticleTVC else { return UITableViewCell() }
                        
                        answer.delegate = self
                        answer.setCardDatas(que: exploreAnswerArray[indexPath.row].question, date: exploreAnswerArray[indexPath.row].answerDate, cate: exploreAnswerArray[indexPath.row].category, content: exploreAnswerArray[indexPath.row ].content, profileImage: exploreAnswerArray[indexPath.row].userProfile, nick: exploreAnswerArray[indexPath.row ].userNickname, isScrap: exploreAnswerArray[indexPath.row].isScrapped!, answerId: exploreAnswerArray[indexPath.row].id, questionId: exploreAnswerArray[indexPath.row].questionID, userId: exploreAnswerArray[indexPath.row].userID)
                        return answer
                    }
                } else {
                    guard let answer = tableView.dequeueReusableCell(withIdentifier: ArticleTVC.identifier, for: indexPath)  as? ArticleTVC else { return UITableViewCell() }
                    
                    answer.delegate = self
                    answer.setCardDatas(que: exploreAnswerArray[indexPath.row].question, date: exploreAnswerArray[indexPath.row].answerDate, cate: exploreAnswerArray[indexPath.row].category, content: exploreAnswerArray[indexPath.row ].content, profileImage: exploreAnswerArray[indexPath.row].userProfile, nick: exploreAnswerArray[indexPath.row ].userNickname, isScrap: exploreAnswerArray[indexPath.row].isScrapped!, answerId: exploreAnswerArray[indexPath.row].id, questionId: exploreAnswerArray[indexPath.row].questionID, userId: exploreAnswerArray[indexPath.row].userID)
                    return answer
                    
                }
            }
        }
    }
}

extension ExploreHomeVC: UITableViewDelegate {
    
    // 애니메이션
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if indexPath.section == 0 || indexPath.section == 1 {
            // no animation
        } else {
            if exploreAnswerArray.isEmpty {
                // no animation
            } else {
                if isTableViewAnimation {
                    if scrollDirection {
                        let rotationTransform = CATransform3DTranslate(CATransform3DIdentity, 0, 50, 0)
                        cell.layer.transform = rotationTransform
                        UIView.animate(withDuration: 0.3, delay: 0, options: [.curveEaseInOut, .allowUserInteraction], animations: {
                            cell.layer.transform = CATransform3DIdentity
                        }) { (_) in
                            
                        }
                    } else {
                        let rotationTransform = CATransform3DTranslate(CATransform3DIdentity, 0, -50, 0)
                        cell.layer.transform = rotationTransform
                        UIView.animate(withDuration: 0.3, delay: 0, options: [.curveEaseInOut, .allowUserInteraction], animations: {
                            cell.layer.transform = CATransform3DIdentity
                        }) { (_) in
                            
                        }
                    }
                    
                } else {
                    // no animation
                }
                
            }
            
        }
    }
}

//MARK: - ScrollViewDelegate

extension ExploreHomeVC: UIScrollViewDelegate {
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            self.stoppedScrolling()
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        self.stoppedScrolling()
    }
    
    private func stoppedScrolling() {
        isTableViewAnimation = false
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let currentOffset = exploreTableView.contentOffset.y
        // iphone safe area 문제 해결 코드
        isTableViewAnimation = true
        view.backgroundColor = currentOffset > 394.0 ? .white : UIColor.init(named: "background")
        exploreTableView.backgroundColor = currentOffset >= 0.0 ? .white : UIColor.init(named: "background")
        
        // animation 문제 해결 코드
        if (lastContentOffset < currentOffset) {
            //scroll up
            scrollDirection = true
            
        } else {
            //scroll down
            scrollDirection = false
        }
        
        
        if (currentOffset < 610.0) {
            hideTabBarWhenScrollingUp()
        } else {
            showTabBarWhenScrollingDown()
        }
        
        lastContentOffset = currentOffset
        
//        for cell in exploreTableView.visibleCells {
//            if let indexPath = exploreTableView.indexPath(for: cell) {
//                if indexPath.row > 5 && indexPath.row >= exploreAnswerArray.count - 3 {
//                    if page > currentPage {
//                        moreButtonAction()
//                        print("moreButtonAction called")
//                    }
//                }
//            }
//        }
    }
}

//MARK: - Private Method
extension ExploreHomeVC {
    
    private func moreButtonAction() {
        currentPage += 1
        setAnswerData(page: currentPage, category: selectedCategoryId, sorting: selectedRecentOrFavorite)
        print("called")
    }
    
    private func setThoughtData() {
        
        ExploreThoughtService.shared.getExploreThought { (result) in
            switch result {
            case .success(let data):
                guard let dt = data as? GenericResponse<[ExploreThoughtData]> else { return }
                
                if let thoughts = dt.data {
                    self.exploreThoughtArray = thoughts
                } else {
                    // empty 화면 만들기
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
    
    private func setAnswerData(page: Int, category: Int, sorting: String) {
        
        var cate: Int?
        if category == 0 {
            cate = nil
        } else {
            cate = category
        }
        
        // 중복으로 같은 데이터값 가져오는 것 막는 해결 코드
        var canGetServerData: Bool = true
        if currentPage == 1 {
            // 서버 통신 이루어져야함
            canGetServerData = true
        } else {
            if currentPageAlreadyGetContainers.contains(currentPage) {
                // 서버 통신 이루어 지면 안됌
                canGetServerData = false
            } else {
                currentPageAlreadyGetContainers.append(currentPage)
                canGetServerData = true
            }
        }
        
        if canGetServerData {
            ExploreAnswerService.shared.getExploreAnswer(page: page, category: cate, sorting: sorting) { (result) in
                switch result {
                case .success(let data):
                    guard let dt = data as? GenericResponse<ExploreAnswerData> else { return }
                    if let dat = dt.data {
                        self.page = dat.pageLen
                        if let ans = dat.answers {
                            
                            if self.currentPage == 1 {
                                self.exploreAnswerArray = ans
                            } else {
                                self.exploreAnswerArray.append(contentsOf: ans)
                            }
                            
                        }
                    } else {
                        // empty view
                        self.exploreAnswerArray = []
                        
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
        
    }
    
    private func setCategoryData() {
        ExploreCategoryService.shared.getExploreCategory { (result) in
            switch result {
            case .success(let data):
                guard let dt = data as? GenericResponse<[ExploreCategory]> else { return }
                if let categories = dt.data {
                    self.categoryArray = categories
                    
                    for var category in self.categoryArray {
                        category.selected = false
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
    
    private func scrapAnswer(answerId: Int) {
        
        ExploreAnswerScrapService.shared.putExploreAnswerScrap(answerId: answerId) { (result) in
            switch result {
            case .success(let data):
                
                guard let dt = data as? GenericResponse<Int> else { return }
                if dt.message == "스크랩 성공" || dt.message == "스크랩 취소 성공" {
                    self.setAnswerData(page: self.currentPage, category: self.selectedCategoryId, sorting: self.selectedRecentOrFavorite)
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
    
    private func setHeaderView() {
        headerViewHeight.constant = 0
        headerView.alpha = 0
    }
    
    private func setTableView() {
        exploreTableView.delegate = self
        exploreTableView.dataSource = self
        exploreTableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 119, right: 0)
    }
    
    private func setNotificationCenter() {
        NotificationCenter.default.addObserver(self, selector: #selector(dismissCommentPage), name: .init("dismissCommentPage"), object: nil)
    }
    
    @objc func dismissCommentPage(_ notification: Notification) {
        guard let userInfo = notification.userInfo as? [String: Any] else { return }
        guard let _ = userInfo["indexPath"] as? Int else { return }
        
        scrollDirection = true
    }
    
    private func adjustScrollViewInset() {
        if #available(iOS 11.0, *) {
            exploreTableView.contentInsetAdjustmentBehavior = .never
        } else {
            automaticallyAdjustsScrollViewInsets = false
        }
        
    }
    
    private func hideTabBarWhenScrollingUp() {
        self.headerViewHeight.constant = 0
        self.headerView.alpha = 0
        UIView.animate(withDuration: 0.2, delay: 0.0, options: [.curveLinear], animations: {
            
            
            self.headerView.layoutIfNeeded()
        }) { _ in
            
            
        }
    }
    
    private func showTabBarWhenScrollingDown() {
        self.headerViewHeight.constant = 32
        self.headerView.alpha = 1
        UIView.animate(withDuration: 0.5, delay: 0.3, options: [.curveLinear], animations: {
            
            
            self.headerView.layoutIfNeeded()
        }) { _ in
            
        }
    }
}


extension ExploreHomeVC: UITableViewButtonSelectedDelegate {
    
    func categoryButtonTapped(_ indexPath: IndexPath, _ categoryId: Int) {
        isTableViewAnimation = false
        scrollDirection = true
        selectedCategoryId = categoryId
        currentPage = 1
        currentPageAlreadyGetContainers.removeAll()
        // 서버 통신
        setAnswerData(page: currentPage, category: selectedCategoryId, sorting: selectedRecentOrFavorite)
        
    }
    
    func recentOrFavoriteButtonTapped(_ indexPath: Int, _ selected: String) {
        isTableViewAnimation = false
        scrollDirection = true
        selectedRecentOrFavorite = selected
        selectedCategoryId = 0
        currentPage = 1
        currentPageAlreadyGetContainers.removeAll()
        setAnswerData(page: currentPage, category: selectedCategoryId , sorting: selectedRecentOrFavorite)
    }
    
    func exploreMoreAnswersButtonDidTapped() {
        currentPage += 1
        setAnswerData(page: currentPage, category: selectedCategoryId, sorting: selectedRecentOrFavorite)
    }
    
    func exploreAnswerScrapButtonDidTapped(_ answerId: Int) {
        isTableViewAnimation = false
        scrapAnswer(answerId: answerId)
    }
    
    func goToMoreAnswerButtonDidTapped(questionId: Int, question: String) {
        guard let detail = self.storyboard?.instantiateViewController(identifier: "ExploreDetailVC") as?
                ExploreDetailVC else { return }
        detail.questionId = questionId
        detail.questionText = question
        self.navigationController?.pushViewController(detail, animated: true)
    }
    
    func goToCommentButtonTapped(_ answerId: Int) {
        guard let comment = UIStoryboard.init(name: "Comment", bundle: nil).instantiateViewController(identifier: "CommentVC") as? CommentVC else { return }
        comment.answerId = answerId
        comment.isMoreButtonHidden = false
        comment.modalPresentationStyle = .fullScreen
        let nc = UINavigationController(rootViewController: comment)
        nc.modalPresentationStyle = .fullScreen
        self.present(nc, animated: true, completion: nil)
    }
    
    func goToAlarmButtonDidTapped() {
        guard let alarm = UIStoryboard.init(name: "Alarm", bundle: nil).instantiateViewController(identifier: "AlarmVC") as? AlarmVC else { return }
        
        self.navigationController?.pushViewController(alarm, animated: true)
    }
    
    func goToFriendButtonDidTapped() {
        guard let vcName = UIStoryboard(name: "Search",
                                        bundle: nil).instantiateViewController(       withIdentifier: "SearchVC") as? SearchVC
        else{
            return
        }
        
        vcName.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(vcName, animated: true)
    }
    
    func goToTodayAnswerButtonDidTapped() {
        
        ExploreWriteService.shared.getExploreWrite { (result) in
            switch result {
            case .success(let data):
                guard let dt = data as? GenericResponse<ExploreWrite> else { return }
                if let answerData = dt.data as? ExploreWrite {
                    var createdAt = answerData.createdAt ?? ""
                    if createdAt != "" {
                        let index = createdAt.index(createdAt.startIndex, offsetBy: 10)
                        createdAt = createdAt.substring(to: index)
                    }
                    let inputData = AnswerDataForViewController(lock: true, questionCategory: answerData.questionCategoryName, answerDate: "", question: answerData.questionTitle, answer: "", index: 0, answerIdx: answerData.answerIdx, questionID: answerData.questionID, createdTime: createdAt, categoryID: answerData.questionCategoryID, id: answerData.id,commentPublicFlag: 1)
                    
                    guard let answerVC = UIStoryboard(name: "Answer",
                                                      bundle: nil).instantiateViewController(
                                                        withIdentifier: "AnswerVC") as? AnswerVC
                    else{
                        
                        return
                    }
                    
                    
                    
                    answerVC.answerData = inputData
                    
                    self.navigationController?.pushViewController(answerVC, animated: true)
                    
                }
                
                print(dt)
                
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
    
    func goToOthersProfileButtonDidTapped(_ userId: Int) {
        guard let profileVC = UIStoryboard(name: "OthersPage",
                                           bundle: nil).instantiateViewController(
                                            withIdentifier: "OthersPageVC") as? OthersPageVC
        else{
            
            return
        }
        profileVC.userID = userId
        self.navigationController?.pushViewController(profileVC, animated: true)
        
        
    }
    
}


//MARK: - TapBarDelegate

extension ExploreHomeVC: ExploreTabBarDelegate {
    func exploreTabDidTapped() {
        self.exploreTableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
    }
}
