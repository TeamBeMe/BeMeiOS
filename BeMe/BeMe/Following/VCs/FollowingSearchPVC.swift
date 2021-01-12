//
//  FollowingSearchPVC.swift
//  BeMe
//
//  Created by Yunjae Kim on 2020/12/30.
//

import UIKit

class FollowingSearchPVC: UIPageViewController {

    let identifiers = ["FollowingSearchVC","FollowerSearchVC"]
    var followers: [FollowingFollows] = []
    var followees: [FollowingFollows] = []
    
    
    lazy var VCArray : [UIViewController] = {
        
        let followingSearchVC = UIStoryboard(name: "FollowSearch", bundle: nil)
            .instantiateViewController(identifier: "FollowingSearchVC") as? FollowingSearchVC
        
        followingSearchVC?.followees = followees
       
        let followerSearchVC = UIStoryboard(name: "FollowSearch", bundle: nil)
            .instantiateViewController(identifier: "FollowerSearchVC") as? FollowerSearchVC
        followerSearchVC?.followers = followers
        
        return [followingSearchVC!,
                followerSearchVC!
        ]
        
    }()
    
    private func VCInstane(storyboardName : String, vcName : String) ->UIViewController{
        

        return UIStoryboard(name : storyboardName, bundle : nil).instantiateViewController(withIdentifier: vcName)
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let firstVC = VCArray.first{
            setViewControllers([firstVC], direction: .forward, animated: true, completion: nil)
        }

        // Do any additional setup after loading the view.
    }
    
  

}
