//
//  OnboardingVC.swift
//  BeMe
//
//  Created by Yunjae Kim on 2021/01/13.
//

import UIKit

class OnboardingVC: UIViewController {
    var pageInstance : OnboardingPVC?
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var jumpButton: UIButton!
    @IBOutlet weak var startButton: UIButton!
    
    
    var pageIndex = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setItems()
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "onboardingPageSegue"{
            pageInstance = segue.destination as? OnboardingPVC
            pageInstance?.onboardingDelegate = self
            guard let firstVC = pageInstance?.VCArray[0] as? OnboardingFirstVC else {return}
            firstVC.onboardingDelegate = self
            guard let secondVC = pageInstance?.VCArray[1] as? OnboardingSecondVC else {return}
            secondVC.onboardingDelegate = self
            guard let thirdVC = pageInstance?.VCArray[2] as? OnboardingThirdVC else {return}
            thirdVC.onboardingDelegate = self
            guard let fourthVC = pageInstance?.VCArray[3] as? OnboardingFourthVC else {return}
            fourthVC.onboardingDelegate = self
          
        }
        
    }
    
    func setItems(){
        pageControl.isUserInteractionEnabled = false
        startButton.alpha = 0
        startButton.makeRounded(cornerRadius: 6)
    }
    
    @IBAction func startButtonAction(_ sender: Any) {
        guard let vcName = UIStoryboard(name: "LogIn", bundle: nil).instantiateViewController(identifier: "LogInVC") as? UINavigationController else {return}
        
        vcName.modalPresentationStyle = .fullScreen
        self.dismiss(animated: false, completion: {
           
          
            self.present(vcName, animated: true, completion: nil)
            
        })
        
    }
    
    
    @IBAction func jumpButtonAction(_ sender: Any) {
        guard let vcName = UIStoryboard(name: "LogIn", bundle: nil).instantiateViewController(identifier: "LogInVC") as? UINavigationController else {return}
        
        vcName.modalPresentationStyle = .fullScreen
        self.dismiss(animated: false, completion: {
           
          
            self.present(vcName, animated: true, completion: nil)
            
        })
    }
    

}
extension OnboardingVC: OnboardingDelegate{
    func toNextPage(to: Int) {
        pageIndex = to
        pageControl.currentPage = to
        if pageIndex == 3{
            UIView.animate(withDuration: 0.5, animations: {
                self.jumpButton.alpha = 0
                self.startButton.alpha = 1
            })
        }
    }
    func toPrevPage(to: Int) {
        
        if pageIndex == 3{
            UIView.animate(withDuration: 0.5, animations: {
                self.jumpButton.alpha = 1
                self.startButton.alpha = 0
            })
        }
        pageIndex = to
        pageControl.currentPage = to
    }
}


protocol OnboardingDelegate{
    func toNextPage(to: Int)
    
    func toPrevPage(to: Int)
    
}
