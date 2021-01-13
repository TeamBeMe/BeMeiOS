//
//  OnboardingPVC.swift
//  BeMe
//
//  Created by Yunjae Kim on 2021/01/13.
//

import UIKit
@objc class KVOObject : NSObject {
    @objc dynamic var curPresentViewIndex: Int = 0
    
}

class OnboardingPVC: UIPageViewController {
    let identifiers = ["OnboardingFirstVC","OnboardingSecondVC","OnboardingThirdVC","OnboardingFourthVC"]
   
    var previousPage: UIViewController?
    var nextPage: UIViewController?
    var realNextPage: UIViewController?
    var onboardingDelegate: OnboardingDelegate?
    
    
    var keyValue = KVOObject()
    
    lazy var VCArray : [UIViewController] = {
      
        
        return [self.VCInstane(storyboardName: "Onboarding", vcName: "OnboardingFirstVC"),
                self.VCInstane(storyboardName: "Onboarding", vcName: "OnboardingSecondVC"),
                self.VCInstane(storyboardName: "Onboarding", vcName: "OnboardingThirdVC"),
                self.VCInstane(storyboardName: "Onboarding", vcName: "OnboardingFourthVC")
        ]
        
    }()
    
    private func VCInstane(storyboardName : String, vcName : String) ->UIViewController{
        

        return UIStoryboard(name : storyboardName, bundle : nil).instantiateViewController(withIdentifier: vcName)
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        self.dataSource = self
        if let firstVC = VCArray.first{
            setViewControllers([firstVC], direction: .forward, animated: true, completion: nil)
        }

        // Do any additional setup after loading the view.
    }
}


extension OnboardingPVC : UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let vcIdx = VCArray.firstIndex(of: viewController) else {return nil}
        
        let prevIdx = vcIdx - 1
        
        
        print("bb")
        
        
        if(prevIdx < 0){
            return nil
            
        }
        else{
            onboardingDelegate?.toPrevPage(to: prevIdx)
            return VCArray[prevIdx]
        }
        
        
        
        
        
    }
    
    
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let vcIdx = VCArray.firstIndex(of: viewController) else {return nil}
        
        let nextIdx = vcIdx + 1

        if(nextIdx >= VCArray.count){
            return nil
        }
        else{
            onboardingDelegate?.toNextPage(to: nextIdx)
            
            return VCArray[nextIdx]
        }
        
        
        
        
        
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {

        if completed {
            previousPage = previousViewControllers[0]
            realNextPage = nextPage
            print(realNextPage)
            if realNextPage is BeMe.OnboardingFirstVC {
                self.keyValue.curPresentViewIndex = 0
                onboardingDelegate?.toNextPage(to: 0)
            }
            else if realNextPage is BeMe.OnboardingSecondVC{
                self.keyValue.curPresentViewIndex = 1
                onboardingDelegate?.toNextPage(to: 1)
            }
            else if realNextPage is BeMe.OnboardingThirdVC{
                self.keyValue.curPresentViewIndex = 2
                onboardingDelegate?.toNextPage(to: 2)
            }
            else{
                self.keyValue.curPresentViewIndex = 3
                onboardingDelegate?.toNextPage(to: 3)
            }
        }

    }




    func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
        nextPage = pendingViewControllers[0]
    }


    
}


