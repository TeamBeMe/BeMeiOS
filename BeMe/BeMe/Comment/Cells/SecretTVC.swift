//
//  SecretTVC.swift
//  BeMe
//
//  Created by 이재용 on 2021/01/06.
//

import UIKit

class SecretTVC: UITableViewCell {
    static let identifier: String = "SecretTVC"
    
    @IBOutlet weak var moreCommentView: UIView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var moreCommentLabel: UILabel!
    @IBOutlet weak var moreImageView: UIImageView!
    
    weak var delegate: UITableViewButtonSelectedDelegate?
    
    var indexPath: IndexPath?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setInformation(date: String) {
        dateLabel.text = date
    }
    
    @IBAction func moreAnswerButtonTapped(_ sender: Any) {
        
        print("SEeleleel")
        delegate?.moreCellButtonDidTapped(to: indexPath!)
    }
}
