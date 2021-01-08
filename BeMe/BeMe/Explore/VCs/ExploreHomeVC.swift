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
            
        } else if indexPath.row == 1 {
            
        } else if indexPath.row == cellNum + 
    }
    

    
}
extension ExploreHomeVC: UITableViewDelegate {
    
}

