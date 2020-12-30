//
//  FollowMoreButtonCVC.swift
//  BeMe
//
//  Created by Yunjae Kim on 2020/12/30.
//

import UIKit

class FollowMoreButtonCVC: UICollectionViewCell {
    static let identifier : String = "FollowMoreButtonCVC"
    
    @IBOutlet weak var moreButton: UIButton!
    
    var followingMoreButtonDelegate : FollowingMoreButtonDelegate?
    
    override func awakeFromNib() {
        moreButton.makeRounded(cornerRadius: 4)
        
    }
    
    
    @IBAction func moreButtonAction(_ sender: Any) {
        
        followingMoreButtonDelegate?.moreButtonAction()
    }
}
