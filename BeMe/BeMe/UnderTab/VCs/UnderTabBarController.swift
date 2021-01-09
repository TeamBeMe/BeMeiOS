//
//  UnderTabBarController.swift
//  BeMe
//
//  Created by Yunjae Kim on 2020/12/30.
//

import UIKit

class UnderTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setTabBar()
       
        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        self.delegate = self
        super.viewDidLayoutSubviews()
        tabBar.frame.size.height = 83
        tabBar.frame.origin.y = view.frame.height - 83
    }
    
    var homeTabBarDelegate: HomeTabBarDelegate?
    var followingTabBarDelegate: FollowingTabBarDelegate?
}


extension UnderTabBarController {
    
    func setTabBar(){

        self.tabBar.barStyle = .black
        self.tabBar.barTintColor = .black
        self.tabBar.unselectedItemTintColor = .white
        self.tabBar.tintColor = .white
        
        
       
        
        guard let homeVC = UIStoryboard(name: "Home", bundle: nil)
            .instantiateViewController(identifier: "HomeVC") as? HomeVC else {
            
                return
        }
        
        homeTabBarDelegate = homeVC
        guard let exploreVC = UIStoryboard(name:"Explore",bundle:nil)
                .instantiateViewController(identifier: "ExploreHomeVC") as? ExploreHomeVC else {
            return
            
        }
        
        
        guard let followingVC = UIStoryboard(name: "Following",
                                        bundle: nil).instantiateViewController(
                                            withIdentifier: "FollowingVC") as? FollowingVC
            else{
            
            return
        }
        followingTabBarDelegate = followingVC
        
        guard let myPageVC = UIStoryboard(name: "Following",
                                        bundle: nil).instantiateViewController(
                                            withIdentifier: "FollowingVC") as? FollowingVC
            else{
            
            return
        }
        
        
        homeVC.title = ""
        exploreVC.title = ""
        followingVC.title = ""
        myPageVC.title = ""
        
        
        self.viewControllers = [homeVC,exploreVC,followingVC,myPageVC]
        let myTabBarItem1 = (self.tabBar.items?[0])! as UITabBarItem
        let myTabBarItem2 = (self.tabBar.items?[1])! as UITabBarItem
        let myTabBarItem3 = (self.tabBar.items?[2])! as UITabBarItem
        let myTabBarItem4 = (self.tabBar.items?[3])! as UITabBarItem
     
        myTabBarItem1.image = UIImage(named:"btnHomeUnselected")
        myTabBarItem1.selectedImage = UIImage(named: "btnHomeSelected")
        
        myTabBarItem2.image = UIImage(named:"btnExploreUnselected")
        myTabBarItem2.selectedImage = UIImage(named:"btnExploreSelected")
        
    
        
        myTabBarItem3.image = UIImage(named:"btnFollowingUnselected")
        myTabBarItem3.selectedImage = UIImage(named:"btnFollowingSelected")
        
        myTabBarItem4.image = UIImage(named:"btnMypageUnselected")
        myTabBarItem4.selectedImage = UIImage(named:"btnMypageSelected")
        
        
    }
    
    
    
    
    
}

extension UnderTabBarController : UITabBarControllerDelegate {
    // UITabBarDelegate
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        
    }


    // UITabBarControllerDelegate
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        if viewController == self.viewControllers![0] {
            homeTabBarDelegate?.homeButtonTapped()
        }
        else if viewController == self.viewControllers![2]{
            followingTabBarDelegate?.followButtonTapped()
        }
    }
    
    
}


extension UITabBar{
    
    open override func sizeThatFits(_ size: CGSize) -> CGSize {
        var sizethatFits = super.sizeThatFits(size)
        
        sizethatFits.height = 0
        
        return sizethatFits
        
        
        
    }
    
    
}
