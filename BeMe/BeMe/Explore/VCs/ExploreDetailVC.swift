//
//  ExploreDetailVC.swift
//  BeMe
//
//  Created by 이재용 on 2021/01/02.
//

import UIKit

class ExploreDetailVC: UIViewController {

    @IBOutlet weak var diffAnswerTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func backButtonTapped(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
}

extension ExploreDetailVC: UITableViewDataSource, UITableViewDelegate {
 
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
 
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let answer = tableView.dequeueReusableCell(withIdentifier: "AnswerTVC", for: indexPath) as? AnswerTVC else { return UITableViewCell() }
        
        return answer
    }
    
    
}
