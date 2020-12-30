//
//  FollowCardCVC.swift
//  BeMe
//
//  Created by Yunjae Kim on 2020/12/30.
//

import UIKit

class FollowCardCVC: UICollectionViewCell {
    static let identifier : String = "FollowCardCVC"
    
    @IBOutlet weak var containView: UIView!
    
    
    override func awakeFromNib() {
        containView.setBorder(borderColor: .lightGray, borderWidth: 1.0)
        containView.makeRounded(cornerRadius: 6)
        
    }
    
    
    
}
