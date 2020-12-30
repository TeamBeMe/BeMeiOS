//
//  FollowSearchVC.swift
//  BeMe
//
//  Created by Yunjae Kim on 2020/12/30.
//

import UIKit

class FollowSearchVC: UIViewController {

    
    var pageInstance : FollowingSearchPVC?
    
    @IBOutlet weak var followingButton: UIButton!
    @IBOutlet weak var followerButton: UIButton!
    @IBOutlet weak var underLineView: UIView!
    @IBOutlet weak var backButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setItems()
        // Do any additional setup after loading the view.
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "followSearchSegue"{
            pageInstance = segue.destination as? FollowingSearchPVC
        }
        
    }
    
    
    @IBAction func followingButtonAction(_ sender: Any) {
        
        followingButton.tintColor = .black
        followerButton.tintColor = .lightGray
        pageInstance?.setViewControllers([(pageInstance?.VCArray[0])!], direction: .reverse,
        animated: true, completion: nil)
        
        
        UIView.animate(withDuration: 0.3, animations: {
            self.underLineView.transform = .identity
        })
            
        
        
    }
    
    
    @IBAction func followerButtonAction(_ sender: Any) {
        followingButton.tintColor = .lightGray
        followerButton.tintColor = .black
        pageInstance?.setViewControllers([(pageInstance?.VCArray[1])!], direction: .forward,
        animated: true, completion: nil)
        
        UIView.animate(withDuration: 0.3, animations: {
            self.underLineView.transform = CGAffineTransform(translationX: 157, y: 0)
            
        })
    }
    
    
    @IBAction func backButtonAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
        
    }
    

}


//MARK:- User Define Functions
extension FollowSearchVC {
    
    func setItems(){
        followingButton.tintColor = .black
        followerButton.tintColor = .lightGray
        backButton.tintColor = .black
        
        
        
    }
    
    
}
