//
//  DiffArticleTVC.swift
//  BeMe
//
//  Created by 이재용 on 2021/01/01.
//

import UIKit

class ArticleTVC: UITableViewCell {
    static let identifier: String = "ArticleTVC"
    
    lazy var isScrapped: Bool = false
    
    @IBOutlet weak var cardView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        cardView.layer.borderWidth = 1
        cardView.layer.borderColor = UIColor.lightGray.cgColor
        cardView.layer.cornerRadius = 8
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
    
    //MARK: - IBAction
    @IBAction func scrapButtonTapped(_ sender: UIButton) {
        
        if isScrapped {
            isScrapped = false
            sender.setImage(UIImage.init(named: "btnScrapUnselected"), for: .normal)
        } else {
            isScrapped = true
            sender.setImage(UIImage.init(named: "btnScrapSelected"), for: .normal)
        }
        
    }
    
    @IBAction func goToDetailExploreVC(_ sender: UIButton) {
        
    }
}
