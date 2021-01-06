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
    
    lazy var popupBackgroundView: UIView = UIView()
    
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
    
    private func setTableView() {
        
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
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
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
            
            cell.alpha = 0.2
            UIView.animate(withDuration: 0.8, animations: {
              
                cell.alpha = 1.0
            })
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
    
    func settingButtonDidTapped() {
        
        popupBackgroundView.animatePopupBackground(true)
        guard let settingActionSheet = UIStoryboard.init(name: "CustomActionSheet", bundle: .main).instantiateViewController(withIdentifier: CustomActionSheet.identifier) as?
                CustomActionSheet else { return }
        
        settingActionSheet.modalPresentationStyle = .overCurrentContext
        self.present(settingActionSheet, animated: true, completion: nil)
    }
}
