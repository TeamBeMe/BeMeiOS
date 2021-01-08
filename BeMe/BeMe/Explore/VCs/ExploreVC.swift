//
//  ExploreVC.swift
//  BeMe
//
//  Created by 이재용 on 2020/12/30.
//

import UIKit

class ExploreVC: UIViewController {
    
    //MARK: - IBOulets
    @IBOutlet weak var exploreScrollView: UIScrollView!
    @IBOutlet weak var highLightBar: UIView!
    @IBOutlet weak var headerHighLightBar: UIView!
    @IBOutlet weak var headerHighLightBarConstraint: NSLayoutConstraint!
    @IBOutlet weak var highLightBarLeading: NSLayoutConstraint!
    @IBOutlet weak var diffArticleSubTitle: UILabel!
    @IBOutlet weak var diffThoughtCollectionView: UICollectionView!
    @IBOutlet weak var diffArticleTableView: UITableView!
    @IBOutlet weak var diffArticleTableViewHeight: NSLayoutConstraint!
    @IBOutlet weak var headerViewTopContraint: NSLayoutConstraint!
    @IBOutlet weak var headerView: UIView! {
        didSet {
            headerView.alpha = 0.0
        }
    }
    @IBOutlet weak var headerViewHeight: NSLayoutConstraint! {
        didSet {
            
            headerViewHeight.constant = minHeight
        }
    }
    
    var diffThoughtArray: [ExploreThoughtData] = []
    
    var diffArticleArray: [ExploreAnswerData] = []
    private var lastContentOffset: CGFloat = 0
    
    private let maxHeight: CGFloat = 32.0
    
    private let minHeight: CGFloat = 0.0
    
    private var cellNumber: Int = 10
    
    private var isRecentButtonPressed: Bool = true
    
    private var currentIndex: CGFloat = 0
    
    private var isOneStepPaging = true
    
    //MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        adjustScrollViewInset()
        setThoughtCollectionView()
        setArticleTableView()
        diffArticleTableView.setDynamicCellHeight(to: 200)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setThoughtData()
        self.view.bringSubviewToFront(headerView)
        navigationController?.navigationBar.isHidden = true
        
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        
        navigationController?.navigationBar.isHidden = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        setTableViewHeight()
        
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    
    //MARK: - IBActions
    
    @IBAction func recentButtonTapped(_ sender: UIButton) {
        moveHighLightBar(to: sender)
        isRecentButtonPressed = true
        setLabel()
        diffArticleTableView.reloadData()
    }
    
    @IBAction func favoriteButtonTapped(_ sender: UIButton) {
        moveHighLightBar(to: sender)
        isRecentButtonPressed = false
        setLabel()
        diffArticleTableView.reloadData()
    }
}

//MARK: - Private Method
extension ExploreVC {
    
    private func setThoughtData() {
        
        ExploreThoughtService.shared.getExploreThought { (result) in
            switch result {
            case .success(let data):
                guard let dt = data as? GenericResponse<[ExploreThoughtData]> else { return }
                
                if let thoughts = dt.data {
                    print(thoughts)
                    self.diffThoughtArray = thoughts
                    self.diffThoughtCollectionView.reloadData()
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
    
    private func setArticleTableView() {
        
    }
    
    private func setNotificationCenter() {
        NotificationCenter.default.addObserver(self, selector: #selector(dismissCommentPage), name: .init("dismissCommentPage"), object: nil)
    }
    
    @objc func dismissCommentPage(_ notification: Notification) {
        guard let userInfo = notification.userInfo as? [String: Any] else { return }
        guard let pageNumber = userInfo["indexPath"] as? Int else { return }
        
        print(pageNumber)
        
    }
    
    private func setThoughtCollectionView() {
        
        let cellWidth: CGFloat = view.bounds.width - 55.0
        let cellHeight: CGFloat = cellWidth * 229.0 / 320.0
        
        // 상하, 좌우 inset value 설정
        let insetX: CGFloat = (view.bounds.width - cellWidth) / 2.0
        let lineSpacing: CGFloat = 12.0
        
        let layout = diffThoughtCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: cellWidth, height: cellHeight)
        layout.minimumLineSpacing = lineSpacing
        layout.scrollDirection = .horizontal
        diffThoughtCollectionView.contentInset = UIEdgeInsets(top: 0, left: insetX, bottom: 0, right: insetX)

        diffThoughtCollectionView.delegate = self
        diffThoughtCollectionView.dataSource = self
        
        diffThoughtCollectionView.decelerationRate = UIScrollView.DecelerationRate.fast
    }
    
    private func setLabel() {
        diffArticleSubTitle.alpha = 0.0
        UIView.animate(withDuration: 0.6, animations: {
            self.diffArticleSubTitle.alpha = 1.0
            self.diffArticleSubTitle.text = self.isRecentButtonPressed ? "내가 답한 질문에 대한 다른 사람들의 최신 답변이에요" : "내가 관심있어 할 다른 사람들의 답변이에요"
            
            
        }) { (_) in
            
        }
        
    }
    
    private func setLayout() {
        headerView.center.y -= view.bounds.height
        
    }
    
    private func setTableViewHeight() {
        diffArticleTableViewHeight.constant = diffArticleTableView.contentSize.height
    }
    
    private func moveHighLightBar(to button: UIButton) {
        
        UIView.animate(withDuration: 0.2, delay: 0, options: [.curveLinear], animations: {
            
            // Slide Animation
            self.highLightBar.frame.origin.x = 30 + button.frame.minX
            self.headerHighLightBar.frame.origin.x = 30 + button.frame.minX
            
            // FadeIn Animation
//                        self.highLightBarLeading.constant = 30 + button.frame.minX
//                        self.headerHighLightBarConstraint.constant = 30 + button.frame.minX
            
        }) { _ in
            
        }
    }
    
    private func adjustScrollViewInset() {
        if #available(iOS 11.0, *) {
            exploreScrollView.contentInsetAdjustmentBehavior = .never
        } else {
            automaticallyAdjustsScrollViewInsets = false
        }
        
    }
    
    private func hideTabBarWhenScrollingUp() {
        UIView.animate(withDuration: 0.1, delay: 0.0, options: [.curveLinear], animations: {
            self.headerViewHeight.constant = self.minHeight
            //            self.headerView.center.y = -self.headerView.frame.height
            self.headerView.alpha = 0.0
        }) { _ in
            
        }
    }
    
    private func showTabBarWhenScrollingDown() {
        UIView.animate(withDuration: 0.3, delay: 0.3, options: [.curveLinear], animations: {
            self.headerViewHeight.constant = self.maxHeight
            //            self.headerView.center.y = self.headerView.frame.height
            self.headerView.alpha = 1.0
        }) { _ in
            
        }
    }
}

//MARK: - ScrollViewDelegate
extension ExploreVC: UIScrollViewDelegate {
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>)
    {
        if scrollView == diffThoughtCollectionView {
            let layout = self.diffThoughtCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
            let cellWidthIncludingSpacing = layout.itemSize.width + layout.minimumLineSpacing
            
            var offset = targetContentOffset.pointee
            let index = (offset.x + scrollView.contentInset.left) / cellWidthIncludingSpacing
            var roundedIndex = round(index)
            
            if scrollView.contentOffset.x > targetContentOffset.pointee.x {
                roundedIndex = floor(index)
            } else if scrollView.contentOffset.x < targetContentOffset.pointee.x {
                roundedIndex = ceil(index)
            } else {
                roundedIndex = round(index)
            }
            
            if isOneStepPaging {
                if currentIndex > roundedIndex {
                    currentIndex -= 1
                    roundedIndex = currentIndex
                } else if currentIndex < roundedIndex {
                    currentIndex += 1
                    roundedIndex = currentIndex
                }
            }
            
            // 위 코드를 통해 페이징 될 좌표값을 targetContentOffset에 대입하면 된다.
            offset = CGPoint(x: roundedIndex * cellWidthIncludingSpacing - scrollView.contentInset.left, y: -scrollView.contentInset.top)
            targetContentOffset.pointee = offset
        }
        
    }
    
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let currentOffset = exploreScrollView.contentOffset.y
        
        // iphone safe area 문제 해결 코드
        self.view.backgroundColor = currentOffset > 388 ? .white : UIColor.init(named: "background")
        
        if (currentOffset > 432 + 69 + 32) {
            if (lastContentOffset < currentOffset) {
                // scroll up
                hideTabBarWhenScrollingUp()
            } else {
                // scroll down
                showTabBarWhenScrollingDown()
            }
        } else {
            hideTabBarWhenScrollingUp()
        }
        
        lastContentOffset = currentOffset
    }
    
}

//MARK: - CollectionViewDelegate
extension ExploreVC: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return diffThoughtArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: DiffThoughtCVC.identifier,
                for: indexPath) as? DiffThoughtCVC else {
            return UICollectionViewCell()
        }
        // border 계산 다시하기
//        let deviceBound: CGFloat = UIScreen.main.bounds.width/375.0
        
//        let width = cell.bounds.width
//        let height = cell.bounds.height
//        cell.layer.cornerRadius = width * 6 *  deviceBound
        
        
        cell.setQuestionAnswer(diffThoughtArray[indexPath.row].questionTitle, diffThoughtArray[indexPath.row].content)
        cell.backgroundColor = .white
        return cell
    }
    
}

//MARK: - TableView

extension ExploreVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellNumber
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            guard let category = tableView
                    .dequeueReusableCell(withIdentifier: CategoryTVC.identifier, for: indexPath)
                    as? CategoryTVC else { return UITableViewCell() }
            category.delegate = self
            category.selectionStyle = .none
            return category
        } else if indexPath.row == cellNumber - 1 {
            guard let more = tableView
                    .dequeueReusableCell(withIdentifier: MoreTVC.identifier, for: indexPath)
                    as? MoreTVC else { return UITableViewCell() }
            
            more.selectionStyle = .none
            
            
            return more
        } else {
            guard let article = tableView
                    .dequeueReusableCell(withIdentifier: ArticleTVC.identifier, for: indexPath)
                    as? ArticleTVC else { return UITableViewCell() }

            article.selectionStyle = .none
            return article
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 62
        } else if indexPath.row == cellNumber - 1 {
            return UITableView.automaticDimension
        } else {
            return UITableView.automaticDimension
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.row == 0 {
            // nothing
        } else if indexPath.row == cellNumber - 1 {
            
        } else {
            guard let comment = UIStoryboard.init(name: "Comment", bundle: nil).instantiateViewController(identifier: "CommentVC") as? CommentVC else { return }
            
            comment.pageNumber = indexPath.row
            comment.isMoreButtonHidden = false
            comment.modalPresentationStyle = .fullScreen
            self.present(comment, animated: true, completion: nil)
        }


    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if indexPath.row == 0 {
            // no animation
            
        } else if indexPath.row == cellNumber - 1 {
            // animation 2
            cell.alpha = 0
            UIView.animate(withDuration: 0.75) {
                
                cell.alpha = 1.0
            }
        } else {
            // animation 1
            let rotationTransform = CATransform3DTranslate(CATransform3DIdentity, 0, 320, 0)
            cell.layer.transform = rotationTransform
            cell.alpha = 0.5
            
            UIView.animate(withDuration: 0.5, delay: 0, options: [.curveEaseInOut], animations: {
                cell.layer.transform = CATransform3DIdentity
                cell.alpha = 1.0
            }) { (_) in
                
            }
            
        }
    }
    
    
}

extension ExploreVC: UITableViewButtonSelectedDelegate {
    
    
}
