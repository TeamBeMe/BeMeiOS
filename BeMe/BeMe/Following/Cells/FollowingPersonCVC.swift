//
//  FollowingPersonCVC.swift
//  BeMe
//
//  Created by Yunjae Kim on 2020/12/30.
//

import UIKit

class FollowingPersonCVC: UICollectionViewCell {
    static let identifier : String = "FollowingPersonCVC"
    
    //MARK:- User Define Function
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    
    
    override func awakeFromNib() {
        profileImage.tintColor = .black
        
    }
    
    
    
}


