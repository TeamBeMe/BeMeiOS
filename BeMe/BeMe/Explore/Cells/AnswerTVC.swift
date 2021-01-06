//
//  AnswerTVC.swift
//  BeMe
//
//  Created by 이재용 on 2021/01/03.
//

import UIKit


class AnswerTVC: UITableViewCell {
    static let identifier: String = "AnswerTVC"
    
    private var isScrapped: Bool = false
    
    weak var delegate: UITableViewButtonSelectedDelegate?
    
    var indexPath: IndexPath?
    
    @IBOutlet weak var answerView: UIView!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        answerView.setBorderWithRadius(borderColor: .lightGray, borderWidth: 1, cornerRadius: 8)
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

    @IBAction func scrapButtonTapped(_ sender: UIButton) {
        
        if isScrapped {
            isScrapped = false
            sender.setImage(UIImage.init(named: "btnScrapUnselected"), for: .normal)
        } else {
            isScrapped = true
            sender.setImage(UIImage.init(named: "btnScrapSelected"), for: .normal)
        }
    }
    
    @IBAction func settingButtonTapped(_ sender: UIButton) {
        
        delegate?.settingButtonDidTapped(to: indexPath!)
    }
}
