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
    
    // 서버통신을 통해 받아오는 값
    var articlesArray: [ExploreAnswer] = [] {
        didSet {
        }
    }
    
    private var categoryArray: [ExploreCategory] = [] {
        didSet {
            exploreTableView.reloadRows(at: [IndexPath(row: 1, section: 0)], with: .none)
        }
    }
    
    private var exploreThoughtArray: [ExploreThoughtData] = [] {
        didSet {
            exploreTableView.reloadRows(at: [IndexPath(row: 0, section: 0)], with: .none)
        }
    }
    
    var cellNum: Int = 10
    
    //MARK: - life cylce
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setAnswerData()
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
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellNum + 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            guard let diffThought = tableView.dequeueReusableCell(withIdentifier: DiffThoughtTVC.identifier, for: indexPath) as? DiffThoughtTVC else { return UITableViewCell() }
            
            diffThought.exploreThoughtArray = self.exploreThoughtArray
            return diffThought
        } else if indexPath.row == 1 {
            guard let diffAnswer = tableView.dequeueReusableCell(withIdentifier: DiffArticleTVC.identifier, for: indexPath) as? DiffArticleTVC else { return UITableViewCell() }
            
            diffAnswer.categoryArray = self.categoryArray
            diffAnswer.delegate = self
            return diffAnswer
        } else if indexPath.row == cellNum + 2 - 1 {
            // 더보기 버튼
            guard let more = tableView.dequeueReusableCell(withIdentifier: MoreTVC.identifier, for: indexPath) as? MoreTVC else { return UITableViewCell() }
            return more
        } else {
            guard let answer = tableView.dequeueReusableCell(withIdentifier: ArticleTVC.identifier, for: indexPath)  as? ArticleTVC else { return UITableViewCell() }
            
            return answer
        }
    }
}
extension ExploreHomeVC: UITableViewDelegate {
    
    // 애니메이션
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == 0  || indexPath.row == 1{
            // no animation
        } else if indexPath.row == cellNum + 2 - 1 {
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
    }
}

//MARK: - ScrollViewDelegate

extension ExploreHomeVC: UIScrollViewDelegate {
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
    
    private func setAnswerData() {
        ExploreAnswerService.shared.getExploreAnswer(page: 1, category: nil, sorting: "최신") { (result) in
            switch result {
            case .success(let data):
                guard let dt = data as? GenericResponse<[ExploreAnswerData]> else { return }
            let _ = dt

            
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
            self.headerView.frame.origin.y =  self.headerFrameOriginY - self.headerView.frame.height
        }) { _ in
            
        }
    }
    
    private func showTabBarWhenScrollingDown() {
        UIView.animate(withDuration: 0.3, delay: 0.3, options: [.curveLinear], animations: {
            self.headerView.frame.origin.y = self.headerFrameOriginY + self.headerView.frame.height
        }) { _ in
            
        }
    }
}


extension ExploreHomeVC: UITableViewButtonSelectedDelegate {
    func categoryButtonTapped(_ indexPath: IndexPath) {
        scrollDirection = true
        exploreTableView.reloadRows(at: [IndexPath(row: 2, section: 0)], with: .none)
    }
    
    func recentOrFavoriteButtonTapped(_ indexPath: Int) {
        scrollDirection = true
        exploreTableView.reloadData()
    }
    
    
}
