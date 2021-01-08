//
//  ExploreHomeVC.swift
//  BeMe
//
//  Created by 이재용 on 2021/01/08.
//

import UIKit

class ExploreHomeVC: UIViewController {

    @IBOutlet weak var exlporeTableView: UITableView!
    
    // 서버통신을 통해 받아오는 값
    var articlesArray: [ExploreAnswer] = []
    
    var diffThoughtArray: [ExploreThoughtData] = []
    
    var cellNum: Int = 10
    
    
    
    //MARK: - life cylce

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.navigationController?.navigationBar.isHidden = false
    }
}

extension ExploreHomeVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellNum + 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            guard let diffThought = tableView.dequeueReusableCell(withIdentifier: DiffThoughtTVC.identifier, for: indexPath) as? DiffThoughtTVC else { return UITableViewCell() }
            
            return diffThought
        } else if indexPath.row == 1 {
            guard let diffAnswer = tableView.dequeueReusableCell(withIdentifier: DiffArticleTVC.identifier, for: indexPath) as? DiffArticleTVC else { return UITableViewCell() }
            
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
            let rotationTransform = CATransform3DTranslate(CATransform3DIdentity, 0, 160, 0)
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

extension ExploreHomeVC: UITableViewButtonSelectedDelegate {
    
    func categoryButtonTapped(_ indexPath: IndexPath) {
        
        exlporeTableView.reloadData()
    }
}
