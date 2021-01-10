//
//  ExploreHomeVC.swift
//  BeMe
//
//  Created by 이재용 on 2021/01/08.
//

import UIKit

class ExploreHomeVC: UIViewController {
    
    @IBOutlet weak var exploreTableView: UITableView!
    @IBOutlet weak var safeAreaView: UIView!
    @IBOutlet weak var headerView: UIView!
    
    private var lastContentOffset: CGFloat = 0
    
    private let maxHeight: CGFloat = 32.0
    
    private let minHeight: CGFloat = 0.0
    
    private let headerFrameOriginY: CGFloat = 56.0
    
    private var scrollDirection: Bool = true
    
    private var page: Int = 1
    
    private var currentPage: Int = 1
    
    private var selectedCategoryId: Int = 0
    
    private var selectedRecentOrFavorite: String = "최신"
    
    // 서버통신을 통해 받아오는 값
    private var categoryArray: [ExploreCategory] = [] {
        didSet {
            exploreTableView.reloadData()
        }
    }
    
    private var exploreThoughtArray: [ExploreThoughtData] = [] {
        didSet {
            exploreTableView.reloadData()
        }
    }
    
    private var exploreAnswerArray: [ExploreAnswer] = [] {
        didSet {
//            let section = IndexSet.init(integer: 2)
            exploreTableView.reloadData()
        }
    }
    
    //MARK: - life cylce
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setAnswerData(page: 1, category: selectedCategoryId, sorting: selectedRecentOrFavorite)
        setThoughtData()
        setCategoryData()

        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.navigationController?.navigationBar.isHidden = false
    }
}

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
            if currentPage < page {
                return 10 + 1
            } else {
                return exploreAnswerArray.count
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
            if currentPage < page {
                if indexPath.row == 11 - 1 {
                    // 더보기 버튼
                    guard let more = tableView.dequeueReusableCell(withIdentifier: MoreTVC.identifier, for: indexPath) as? MoreTVC else { return UITableViewCell() }
                    return more
                } else {
                    guard let answer = tableView.dequeueReusableCell(withIdentifier: ArticleTVC.identifier, for: indexPath)  as? ArticleTVC else { return UITableViewCell() }
                    
                    answer.delegate = self
                    answer.setCardDatas(que: exploreAnswerArray[indexPath.row].question, date: exploreAnswerArray[indexPath.row].answerDate, cate: exploreAnswerArray[indexPath.row].category, content: exploreAnswerArray[indexPath.row ].content, profileImage: exploreAnswerArray[indexPath.row].userProfile, nick: exploreAnswerArray[indexPath.row ].userNickname, isScrap: exploreAnswerArray[indexPath.row].isScrapped!, answerId: exploreAnswerArray[indexPath.row].id, questionId: exploreAnswerArray[indexPath.row].questionID)
                    return answer
                }
            } else {
                guard let answer = tableView.dequeueReusableCell(withIdentifier: ArticleTVC.identifier, for: indexPath)  as? ArticleTVC else { return UITableViewCell() }
                
                answer.delegate = self
                answer.setCardDatas(que: exploreAnswerArray[indexPath.row].question, date: exploreAnswerArray[indexPath.row].answerDate, cate: exploreAnswerArray[indexPath.row].category, content: exploreAnswerArray[indexPath.row ].content, profileImage: exploreAnswerArray[indexPath.row].userProfile, nick: exploreAnswerArray[indexPath.row ].userNickname, isScrap: exploreAnswerArray[indexPath.row].isScrapped!, answerId: exploreAnswerArray[indexPath.row].id, questionId: exploreAnswerArray[indexPath.row].questionID)
                return answer
                
            }
        }
    }
}

extension ExploreHomeVC: UITableViewDelegate {
    
    // 애니메이션
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        if indexPath.section == 0 || indexPath.section == 1 {
//            // no animation
//        } else {
//            if currentPage < page {
//                if indexPath.row == 11 - 1 {
//                    // animation 2
//                    cell.alpha = 0
//                    UIView.animate(withDuration: 0.75) {
//                        
//                        cell.alpha = 1.0
//                    }
//                } else {
//                    // animation 1
//                    if (scrollDirection) {
//                        // up
//                        let rotationTransform = CATransform3DTranslate(CATransform3DIdentity, 0, 50, 0)
//                        cell.layer.transform = rotationTransform
//                        UIView.animate(withDuration: 0.3, delay: 0, options: [.curveEaseInOut], animations: {
//                            cell.layer.transform = CATransform3DIdentity
//                        }) { (_) in
//                            
//                        }
//                    } else {
//                        // down
//                        let rotationTransform = CATransform3DTranslate(CATransform3DIdentity, 0, -50, 0)
//                        cell.layer.transform = rotationTransform
//                        UIView.animate(withDuration: 0.3, animations: {
//                            cell.layer.transform = CATransform3DIdentity
//                        })
//                    }
//                }
//            } else {
//                // animation 1
//                if (scrollDirection) {
//                    // up
//                    let rotationTransform = CATransform3DTranslate(CATransform3DIdentity, 0, 50, 0)
//                    cell.layer.transform = rotationTransform
//                    UIView.animate(withDuration: 0.3, delay: 0, options: [.curveEaseInOut], animations: {
//                        cell.layer.transform = CATransform3DIdentity
//                    }) { (_) in
//                        
//                    }
//                } else {
//                    // down
//                    let rotationTransform = CATransform3DTranslate(CATransform3DIdentity, 0, -50, 0)
//                    cell.layer.transform = rotationTransform
//                    UIView.animate(withDuration: 0.3, animations: {
//                        cell.layer.transform = CATransform3DIdentity
//                    })
//                }
//            }
//        }
//        
//        if indexPath.row == 0 || indexPath.row == 1 {
//            // no animation
//        } else if indexPath.row == cellNum + 2 - 1 {
//        } else {
//            
//            
//            
//        }
    }
}

//MARK: - ScrollViewDelegate

extension ExploreHomeVC: UIScrollViewDelegate {
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
//        print("stop Dragging")
        print(scrollDirection)
        let currentOffset = exploreTableView.contentOffset.y
        
        if currentOffset > 542.333 {
            if (scrollDirection) {
                
            } else {
                
            }
        }
        
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let currentOffset = exploreTableView.contentOffset.y
        //        print(currentOffset)
        
        
        // iphone safe area 문제 해결 코드
        self.safeAreaView.backgroundColor = currentOffset > 394 ? .white : UIColor.init(named: "background")
        view.backgroundColor = currentOffset > 394 ? .white : UIColor.init(named: "background")
        // animation 문제 해결 코드
        if (lastContentOffset < currentOffset) {
            //scroll up
            scrollDirection = true
        } else {
            //scroll down
            scrollDirection = false
        }
        
        // 상단 view
        if (currentOffset > 542.333) {
            if (lastContentOffset < currentOffset) {
                //scroll up
                
                hideTabBarWhenScrollingUp()
            } else {
                //scroll down
                
                showTabBarWhenScrollingDown()
                
            }
        } else {
            //hideTabBarWhenScrollingUp()
        }
        //
        lastContentOffset = currentOffset
    }
}

//MARK: - Private Method
extension ExploreHomeVC {
    
    private func setThoughtData() {
        
        ExploreThoughtService.shared.getExploreThought { (result) in
            switch result {
            case .success(let data):
                guard let dt = data as? GenericResponse<[ExploreThoughtData]> else { return }
                
                if let thoughts = dt.data {
                    self.exploreThoughtArray = thoughts
                } else {
                    print("none")
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
    
    private func setAnswerData(page: Int?, category: Int?, sorting: String) {
        
        var c: Int?
        if let p = page {
            if category == 0 {
                c = nil
                ExploreAnswerService.shared.getExploreAnswer(page: p, category: c, sorting: sorting) { (result) in
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
            } else {
                if let cate = category {
                    c = cate
                    ExploreAnswerService.shared.getExploreAnswer(page: p, category: c, sorting: sorting) { (result) in
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
                
                guard let dt = data as? GenericResponse<[ExploreCategory]> else { return }
                print(dt.message)
                if dt.message == "스크랩 성공" {
                    // 사용자한테 성공했다고 알려주는 동작
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
        guard let pageNumber = userInfo["indexPath"] as? Int else { return }
        
        print(pageNumber)
    }
    
    private func adjustScrollViewInset() {
        if #available(iOS 11.0, *) {
            exploreTableView.contentInsetAdjustmentBehavior = .never
        } else {
            automaticallyAdjustsScrollViewInsets = false
        }
        
    }
    
    private func hideTabBarWhenScrollingUp() {
        UIView.animate(withDuration: 0.1, delay: 0.0, options: [.curveLinear], animations: {
            self.headerView.center.y =  self.headerFrameOriginY - self.headerView.frame.height
            
            print(self.headerView.center.y)
        }) { _ in
            
            
        }
    }
    
    private func showTabBarWhenScrollingDown() {
        UIView.animate(withDuration: 0.3, delay: 0.3, options: [.curveLinear], animations: {
            self.headerView.center.y = self.headerFrameOriginY + self.headerView.frame.height
            
            print(self.headerView.center.y)
        }) { _ in
            
        }
    }
}


extension ExploreHomeVC: UITableViewButtonSelectedDelegate {
    func categoryButtonTapped(_ indexPath: IndexPath, _ categoryId: Int) {
        scrollDirection = true
        selectedCategoryId = categoryId
        
        // 서버 통신
        setAnswerData(page: currentPage, category: selectedCategoryId, sorting: selectedRecentOrFavorite)
        
    }
    
    func recentOrFavoriteButtonTapped(_ indexPath: Int, _ selected: String) {
        scrollDirection = true
        selectedRecentOrFavorite = selected
        selectedCategoryId = 0
        setAnswerData(page: currentPage, category: selectedCategoryId , sorting: selectedRecentOrFavorite)
    }
    
    func exploreMoreAnswersButtonDidTapped() {
        currentPage += 1
        setAnswerData(page: currentPage, category: selectedCategoryId, sorting: selectedRecentOrFavorite)
    }
    
    func exploreAnswerScrapButtonDidTapped(_ answerId: Int) {
        print(answerId)
        
        scrapAnswer(answerId: answerId)
        
    }
    
    func goToMoreAnswerButtonDidTapped(questionId: Int, question: String) {
        print("ExploreHomeVC")
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
        self.present(comment, animated: true, completion: nil)
    }
}
