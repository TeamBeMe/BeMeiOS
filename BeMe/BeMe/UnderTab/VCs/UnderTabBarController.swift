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
        
        
        guard let exploreVC = UIStoryboard(name:"Explore",bundle:nil)
                .instantiateViewController(identifier: "ExploreVC") as? ExploreVC else {
            return
            
        }
        
        
        guard let followingVC = UIStoryboard(name: "Following",
                                        bundle: nil).instantiateViewController(
                                            withIdentifier: "FollowingVC") as? UINavigationController
            else{
            
            return
        }
        
        guard let myPageVC = UIStoryboard(name: "Following",
                                        bundle: nil).instantiateViewController(
                                            withIdentifier: "FollowingVC") as? UINavigationController
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
     
        myTabBarItem1.image = UIImage(systemName: "house")
        myTabBarItem1.selectedImage = UIImage(systemName: "house.fill")
        
        myTabBarItem2.image = UIImage(systemName: "square.grid.2x2")
        myTabBarItem2.selectedImage = UIImage(systemName: "square.grid.2x2.fill")
        
    
        
        myTabBarItem3.image = UIImage(systemName: "heart")
        myTabBarItem3.selectedImage = UIImage(systemName: "heart.fill")
        
        myTabBarItem4.image = UIImage(systemName: "person")
        myTabBarItem4.selectedImage = UIImage(systemName: "person.fill")
        
        
    }
    
    
    
    
    
}


extension UITabBar{
    
    open override func sizeThatFits(_ size: CGSize) -> CGSize {
        var sizethatFits = super.sizeThatFits(size)
        
        sizethatFits.height = 0
        
        return sizethatFits
        
        
        
    }
    
    
}
