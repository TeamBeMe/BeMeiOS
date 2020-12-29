//
//  FollowingVC.swift
//  BeMe
//
//  Created by Yunjae Kim on 2020/12/30.
//

import UIKit

class FollowingVC: UIViewController {

    @IBOutlet weak var upperContainerView: UIView!
    @IBOutlet weak var addFriendButton: UIButton!
    @IBOutlet weak var alarmButton: UIButton!
    @IBOutlet weak var followingButton: UIButton!
    @IBOutlet weak var followerButton: UIButton!
    
    @IBOutlet weak var underLineView: UIView!
    @IBOutlet weak var barButton: UIButton!
    var pageInstance : FollowingPVC?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setItems()
       
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "pageSegue"{
            pageInstance = segue.destination as? FollowingPVC
        }
        
    }
    
    
    
    @IBAction func followerButtonAction(_ sender: Any) {
        pageInstance?.setViewControllers([(pageInstance?.VCArray[1])!], direction: .forward,
        animated: true, completion: nil)
        followerButton.tintColor = .black
        followingButton.tintColor = .lightGray
        UIView.animate(withDuration: 0.3, animations: {
            self.underLineView.transform = CGAffineTransform(translationX: 70, y: 0)
            
        })
        
    }
    
    
    @IBAction func followingButtonAction(_ sender: Any) {
        
        pageInstance?.setViewControllers([(pageInstance?.VCArray[0])!], direction: .reverse,
        animated: true, completion: nil)
        followerButton.tintColor = .lightGray
        followingButton.tintColor = .black
        UIView.animate(withDuration: 0.3, animations: {
            self.underLineView.transform = .identity
            
        })
        
    }
    
    
}



//MARK:- User Define Functions
extension FollowingVC {
    
    func setItems(){
        upperContainerView.setBorder(borderColor: .lightGray, borderWidth: 1.0)
        addFriendButton.tintColor = .black
        alarmButton.tintColor = .black
        followingButton.tintColor = .black
        followerButton.tintColor = .lightGray
        barButton.tintColor = .black
        
        
        
    }
    
    
    
    
    
    
}
