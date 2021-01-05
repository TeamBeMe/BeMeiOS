//
//  SignUpPVC.swift
//  BeMe
//
//  Created by Yunjae Kim on 2021/01/05.
//

import UIKit

class SignUpPVC: UIPageViewController {
    let identifiers = ["SignUpVC","SingUpProfileVC"]

    
    
    lazy var VCArray : [UIViewController] = {
      
        
        return [self.VCInstane(storyboardName: "SignUp", vcName: "SignUpVC"),
                self.VCInstane(storyboardName: "SignUp", vcName: "SingUpProfileVC")
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
