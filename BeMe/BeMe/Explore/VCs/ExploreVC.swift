//
//  ExploreVC.swift
//  BeMe
//
//  Created by 이재용 on 2020/12/30.
//

import UIKit

class ExploreVC: UIViewController {
    
    private var lastContentOffset: CGFloat = 0
    private let maxHeight: CGFloat = 32.0
    private let minHeight: CGFloat = 0.0
    private var cellNumber: Int = 10
    
    //MARK: - IBOulets
    @IBOutlet weak var exploreScrollView: UIScrollView!
    @IBOutlet weak var highLightBar: UIView!
    @IBOutlet weak var headerHighLightBar: UIView!
    @IBOutlet weak var highLightBarLeading: NSLayoutConstraint!
    @IBOutlet weak var diffThoughtCollectionView: UICollectionView!
    @IBOutlet weak var diffArticleTableView: UITableView!
    @IBOutlet weak var diffArticleTableViewHeight: NSLayoutConstraint!
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
    
    //MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        adjustScrollViewInset()
        diffArticleTableView.setDynamicCellHeight(to: 200)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
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
    
    
    //MARK: - IBActions
    
    @IBAction func recentButtonTapped(_ sender: UIButton) {
        moveHighLightBar(to: sender)
        
        diffArticleTableView.reloadData()
    }
    @IBAction func favoriteButtonTapped(_ sender: UIButton) {
        moveHighLightBar(to: sender)
        
        diffArticleTableView.reloadData()
    }
}

//MARK: - Private Method
extension ExploreVC {
    
    private func setLayout() {
        headerView.translatesAutoresizingMaskIntoConstraints = false
        
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
            //self.highLightBarLeading.constant = 30 + button.frame.minX
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
            self.headerView.alpha = 0.0
        }) { _ in
            
        }
    }
    
    private func showTabBarWhenScrollingDown() {
        UIView.animate(withDuration: 0.3, delay: 0.3, options: [.curveLinear], animations: {
            self.headerViewHeight.constant = self.maxHeight
            self.headerView.alpha = 1.0
        }) { _ in
            
        }
    }
}

//MARK: - ScrollViewDelegate
extension ExploreVC: UIScrollViewDelegate {
    
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
extension ExploreVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 28, bottom: 10, right: 30)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 320.0, height: 229.0)
    }
}

extension ExploreVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: DiffThoughtCVC.identifier,
                for: indexPath) as? DiffThoughtCVC else {
            return UICollectionViewCell()
        }
        cell.layer.cornerRadius = 8
        cell.setAnswer()
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
            guard let header = tableView
                    .dequeueReusableCell(withIdentifier: CategoryTVC.identifier, for: indexPath)
                    as? CategoryTVC else { return UITableViewCell() }
            return header
        } else if indexPath.row == cellNumber - 1 {
            guard let more = tableView
                    .dequeueReusableCell(withIdentifier: MoreTVC.identifier, for: indexPath)
                    as? MoreTVC else { return UITableViewCell() }
            
            more.isUserInteractionEnabled = false
            
            return more
        } else {
            guard let article = tableView
                    .dequeueReusableCell(withIdentifier: ArticleTVC.identifier, for: indexPath)
                    as? ArticleTVC else { return UITableViewCell() }
            
            
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
            let rotationTransform = CATransform3DTranslate(CATransform3DIdentity, 0, 150, 0)
            cell.layer.transform = rotationTransform
            cell.alpha = 0.5
            
            UIView.animate(withDuration: 0.5, animations: {
                cell.layer.transform = CATransform3DIdentity
                cell.alpha = 1.0
            })
            
            
        }
        
    }
}
