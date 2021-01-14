//
//  SignUpControlVC.swift
//  BeMe
//
//  Created by Yunjae Kim on 2021/01/05.
//

import UIKit

class SignUpControlVC: UIViewController {
    var pageInstance : SignUpPVC?
    
    @IBOutlet weak var backButton: UIButton!
 

    
    @IBOutlet weak var progressBar: UIProgressView!
    
    

    
    var vcIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startAnimation()
        progressBar.tintColor = .black
        progressBar.trackTintColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
        
        
      
        

        // Do any additional setup after loading the view.
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "signUpSegue"{
            pageInstance = segue.destination as? SignUpPVC
            guard let firstVC = pageInstance?.VCArray[0] as? SignUpNoticeVC else {return}
            firstVC.signUpNextButtonDelegate = self
            guard let secondVC = pageInstance?.VCArray[1] as? SignUpAgreeVC else {return}
            secondVC.signUpNextButtonDelegate = self
            guard let thirdVC = pageInstance?.VCArray[2] as? SignUpVC else {return}
            thirdVC.signUpNextButtonDelegate = self
          
        }
        
    }
    
    @IBAction func backButtonAction(_ sender: Any) {
        switch vcIndex {
        case 0:
            self.navigationController?.popViewController(animated: true)
        case 1:
            pageInstance?.setViewControllers([(pageInstance?.VCArray[0])!], direction: .reverse,
            animated: true, completion: nil)
            vcIndex = vcIndex - 1
            progressBar.progress = 0.25
            UIView.animate(withDuration: 1.0, animations: {
                self.progressBar.layoutIfNeeded()
            })
        case 2:
            pageInstance?.setViewControllers([(pageInstance?.VCArray[1])!], direction: .reverse,
            animated: true, completion: nil)
            vcIndex = vcIndex - 1
            progressBar.progress = 0.5
            UIView.animate(withDuration: 1.0, animations: {
                self.progressBar.layoutIfNeeded()
            })
        case 3:
            pageInstance?.setViewControllers([(pageInstance?.VCArray[2])!], direction: .reverse,
            animated: true, completion: nil)
            vcIndex = vcIndex - 1
            progressBar.progress = 0.75
            UIView.animate(withDuration: 1.0, animations: {
                self.progressBar.layoutIfNeeded()
            })
            
        default:
            return
        
        }
        
        
        
        
    }
    func startAnimation(){
        
        progressBar.progress = 0.25
        UIView.animate(withDuration: 1.0, animations: {
            self.progressBar.layoutIfNeeded()
        })
        
    }

}



extension SignUpControlVC: SignUpNextButtonDelegate{
    func nextButtonTapped(email: String,nickName: String,password: String) {
        switch vcIndex{
        case 0:
            guard let vcName = pageInstance?.VCArray[1] as? SignUpAgreeVC else {return}
            vcIndex = vcIndex+1
            pageInstance?.setViewControllers([(pageInstance?.VCArray[1])!], direction: .forward,
            animated: true, completion: nil)
            progressBar.progress = 0.5
            UIView.animate(withDuration: 1.0, animations: {
                self.progressBar.layoutIfNeeded()
            })
        case 1:
            guard let vcName = pageInstance?.VCArray[2] as? SignUpVC else {return}
            vcIndex = vcIndex+1
            pageInstance?.setViewControllers([(pageInstance?.VCArray[2])!], direction: .forward,
            animated: true, completion: nil)
            progressBar.progress = 0.75
            UIView.animate(withDuration: 1.0, animations: {
                self.progressBar.layoutIfNeeded()
            })
        case 2:
            guard let vcName = pageInstance?.VCArray[3] as? SignUpProfileVC else {return}
            vcIndex = vcIndex+1
            pageInstance?.setViewControllers([(pageInstance?.VCArray[3])!], direction: .forward,
            animated: true, completion: nil)
            vcName.myName = nickName
            vcName.myEmail = email
            vcName.myPassword = password
            
            vcName.setNickname(nickName: nickName)
            progressBar.progress = 1.0
            UIView.animate(withDuration: 1.0, animations: {
                self.progressBar.layoutIfNeeded()
            })
        case 3:
            return
        default:
            return
        
        
        
        }
       
    }
}

protocol SignUpNextButtonDelegate {
    func nextButtonTapped(email: String,nickName: String,password: String)
    
}

extension SignUpVC: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
          return true
      }
}
