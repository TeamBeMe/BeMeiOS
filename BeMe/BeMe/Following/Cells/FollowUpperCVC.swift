//
//  FollowUpperCVC.swift
//  BeMe
//
//  Created by Yunjae Kim on 2020/12/31.
//

import UIKit

class FollowUpperCVC: UICollectionViewCell {
    static let identifier : String = "FollowUpperCVC"
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var plusButton: UIButton!
    @IBOutlet weak var bellButton: UIButton!
    @IBOutlet weak var followingButton: UIButton!
    @IBOutlet weak var followerButton: UIButton!
    @IBOutlet weak var barButton: UIButton!
    @IBOutlet weak var borderView: UIView!
    @IBOutlet weak var underLIneView: UIView!
    
    var followingBarButtonDelegate : FollowingBarButtonDelegate?

    
    var followingPeopleCollectionViewDelegate : FollowingPeopleCollectionViewDelegate?
    var followPeopleCollectionViewDelegate : FollowPeopleCollectionViewDelegate?
    
    
    override func awakeFromNib() {
        plusButton.tintColor = .black
        bellButton.tintColor = .black
        followingButton.tintColor = .black
        followerButton.tintColor = .lightGray
        barButton.tintColor = .black
        borderView.backgroundColor = .lightGray

    }
    
    @IBAction func followingButtonAction(_ sender: Any) {
        followerButton.tintColor = .lightGray
        followingButton.tintColor = .black
        UIView.animate(withDuration: 0.3, animations: {
            self.underLIneView.transform = .identity
            
        })
        followingPeopleCollectionViewDelegate?.followingPeopleUpdate()
    }
    
    
    @IBAction func followerButtonAction(_ sender: Any) {
        followerButton.tintColor = .black
        followingButton.tintColor = .lightGray
        UIView.animate(withDuration: 0.3, animations: {
            self.underLIneView.transform = CGAffineTransform(translationX: 70, y: 0)
            
        })
        followPeopleCollectionViewDelegate?.followPeopleUpdate()
        
    }
    
    @IBAction func barButtonAction(_ sender: Any) {
        followingBarButtonDelegate?.barButtonAction()
        
    }
    
    
    
}


