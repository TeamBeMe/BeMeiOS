//
//  ExploreDetailVC.swift
//  BeMe
//
//  Created by 이재용 on 2021/01/02.
//

import UIKit

class ExploreDetailVC: UIViewController {
    
    private var cellNumber: Int = 10
    
    private var lastContentOffset: CGFloat = 0.0
    
    private var scrollDirection: Bool = true
    
    private var currentPage: Int = 1
    
    private var page: Int = 1
    
    lazy var popupBackgroundView: UIView = UIView()
    
    private var exploreAnswerArray: [ExploreAnswer] = [] {
        didSet {
            diffAnswerTableView.reloadData()
        }
    }
    
    @IBOutlet weak var diffAnswerTableView: UITableView!
    
    //MARK: - Life Cycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.navigationBar.isHidden = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        //        print(diffAnswerTableView.contentSize.height)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setPopupBackgroundView()
        setNotificationCenter()
        setTableView()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    //MARK: - IBAction
    
    @IBAction func backButtonTapped(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
}

//MARK: - Private Method
extension ExploreDetailVC {
    
    private func setAnswerData(_ sorting: String) {
        ExploreAnswerService.shared.getExploreAnswer(page: currentPage, category: nil, sorting: sorting) { (result) in
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
    
    private func setTableView() {
        diffAnswerTableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 119, right: 0)
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
            return 10 + 1
        } else {
            return exploreAnswerArray.count
        }
        if indexPath.row == cellNumber - 1 {
            guard let more = tableView.dequeueReusableCell(withIdentifier: DetailMoreTVC.identifier,
                                                           for: indexPath) as? DetailMoreTVC else {
                return UITableViewCell() }
            
            more.isUserInteractionEnabled = false
            return more
        } else {
            guard let answer = tableView.dequeueReusableCell(withIdentifier: AnswerTVC.identifier,
                                                             for: indexPath) as? AnswerTVC else {
                return UITableViewCell() }
            
            answer.selectionStyle = .none
            answer.delegate = self
            answer.indexPath = indexPath
            return answer
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == cellNumber - 1 {
            return 24 + 50 + 119
        } else {
            return UITableView.automaticDimension
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if (scrollDirection) {
            let rotationTransform = CATransform3DTranslate(CATransform3DIdentity, 0, 350, 0)
            cell.layer.transform = rotationTransform
            cell.alpha = 0.5
            
            
            UIView.animate(withDuration: 0.5, delay: 0, options: [.curveEaseInOut], animations: {
                cell.layer.transform = CATransform3DIdentity
                cell.alpha = 1.0
            }) { (_) in
                
            }
        } else {
            let rotationTransform = CATransform3DTranslate(CATransform3DIdentity, 0, -350, 0)
            cell.layer.transform = rotationTransform
            cell.alpha = 0.5
            
            
            UIView.animate(withDuration: 0.5, delay: 0, options: [.curveEaseInOut], animations: {
                cell.layer.transform = CATransform3DIdentity
                cell.alpha = 1.0
            }) { (_) in
                
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
        
        guard let comment = UIStoryboard.init(name: "Comment", bundle: nil).instantiateViewController(identifier: "CommentVC") as? CommentVC else { return }
        
        //        comment.
        comment.isMoreButtonHidden = true
        comment.modalPresentationStyle = .fullScreen
        self.present(comment, animated: true, completion: nil)
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
