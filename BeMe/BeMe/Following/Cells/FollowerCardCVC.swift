//
//  FollowerCardCVC.swift
//  BeMe
//
//  Created by Yunjae Kim on 2020/12/30.
//

import UIKit

class FollowerCardCVC: UICollectionViewCell {
    static let identifier : String = "FollowerCardCVC"
    
    @IBOutlet weak var containView: UIView!
    
    override func awakeFromNib() {
        containView.setBorder(borderColor: .gray, borderWidth: 1.0)
        containView.makeRounded(cornerRadius: 6)
        
    }
    
    
}
