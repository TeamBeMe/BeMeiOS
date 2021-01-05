//
//  CommentVC.swift
//  BeMe
//
//  Created by 이재용 on 2021/01/05.
//

import UIKit

class CommentVC: UIViewController {

    @IBOutlet weak var informationView: UIView!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var cateogryLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nickNameLabel: UILabel!
    @IBOutlet weak var answerTextView: UITextView!
    @IBOutlet weak var moreAnswerButton: UIButton!
    @IBOutlet weak var commentTableView: UITableView!
    
    private var commentArray = [{}]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setView()
        setTableView()
        moreAnswerButton.isHidden = true
    }
    

}
//MARK: - Private Method
extension CommentVC {
    
    private func setView() {
        
    }
    
    private func setTableView() {
        commentTableView.delegate = self
        commentTableView.dataSource = self
    }
}

//MARK: - UITableViewDelegate

extension CommentVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return commentArray.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comment
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
    
    
    
}
