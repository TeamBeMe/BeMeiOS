//
//  FollowerListCVC.swift
//  BeMe
//
//  Created by Yunjae Kim on 2020/12/30.
//

import UIKit

class FollowerListCVC: UICollectionViewCell {
    static let identifier : String = "FollowerListCVC"
    
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var moreButton: UIButton!
    
    override func awakeFromNib() {
        userNameLabel.text = "follower"
        moreButton.tintColor = .black
        
        
    }
    
    
    
    
}
