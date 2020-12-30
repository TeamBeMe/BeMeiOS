//
//  FollowingCardCVC.swift
//  BeMe
//
//  Created by Yunjae Kim on 2020/12/30.
//

import UIKit

class FollowingCardCVC: UICollectionViewCell {
    static let identifier : String = "FollowingCardCVC"
    
    @IBOutlet weak var containView: UIView!
    
    
    override func awakeFromNib() {
        containView.setBorder(borderColor: .gray, borderWidth: 1.0)
        containView.makeRounded(cornerRadius: 6)
        
    }
    
}
