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
    
    @IBOutlet weak var answerCardView: UIView!
    @IBOutlet weak var answerTextView: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        answerCardView.setBorderWithRadius(borderColor: .lightGray, borderWidth: 1, cornerRadius: 8)
        answerTextView.font = UIFont(name: "AppleSDGothicNeo-Light", size: 14.0)
        
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
        print("?????????????뭐지")
    }
}
