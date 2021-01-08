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
            guard let vcName = pageInstance?.VCArray[0] as? SignUpVC else {return}
            vcName.signUpNextButtonDelegate = self
          
        }
        
    }
    
    @IBAction func backButtonAction(_ sender: Any) {
        if vcIndex == 0{
            self.navigationController?.popViewController(animated: true)
        }
        else{
          
            pageInstance?.setViewControllers([(pageInstance?.VCArray[0])!], direction: .reverse,
            animated: true, completion: nil)
            vcIndex = 0
            progressBar.progress = 0.5
            UIView.animate(withDuration: 1.0, animations: {
                self.progressBar.layoutIfNeeded()
            })
        }
        
    }
    func startAnimation(){
        
        progressBar.progress = 0.5
        UIView.animate(withDuration: 1.0, animations: {
            self.progressBar.layoutIfNeeded()
        })
        
    }

}



extension SignUpControlVC: SignUpNextButtonDelegate{
    func nextButtonTapped(email: String,nickName: String,password: String) {
        guard let vcName = pageInstance?.VCArray[1] as? SignUpProfileVC else {return}
        vcIndex = vcIndex+1
        pageInstance?.setViewControllers([(pageInstance?.VCArray[1])!], direction: .forward,
        animated: true, completion: nil)
        vcName.myName = nickName
        vcName.myEmail = email
        vcName.myPassword = password
        
        vcName.setNickname(nickName: nickName)
        progressBar.progress = 1.0
        UIView.animate(withDuration: 1.0, animations: {
            self.progressBar.layoutIfNeeded()
        })
    }
}

protocol SignUpNextButtonDelegate {
    func nextButtonTapped(email: String,nickName: String,password: String)
    
}
