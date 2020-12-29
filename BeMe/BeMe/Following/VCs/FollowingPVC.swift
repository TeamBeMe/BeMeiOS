//
//  FollowingPVC.swift
//  BeMe
//
//  Created by Yunjae Kim on 2020/12/30.
//

import UIKit

class FollowingPVC: UIPageViewController {

    let identifiers = ["FollowingInfoVC","FollowerInfoVC"]
    
    lazy var VCArray : [UIViewController] = {
        return [self.VCInstane(storyboardName: "FollowInfo", vcName: "FollowingInfoVC"),
                self.VCInstane(storyboardName: "FollowInfo", vcName: "FollowerInfoVC")
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
