//
//  LogInVC.swift
//  BeMe
//
//  Created by Yunjae Kim on 2021/01/05.
//

import UIKit

class LogInVC: UIViewController {
    
    @IBOutlet weak var labelContainView: UIView!
    
    @IBOutlet weak var bemeLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var showButton: UIButton!
    
    @IBOutlet weak var containViewHeight: NSLayoutConstraint!
    @IBOutlet weak var nickNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var logInButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    
    
    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()
        setItems()
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func showButtonAction(_ sender: Any) {
        if showButton.titleLabel?.text == "SHOW"{
            passwordTextField.isSecureTextEntry = false
            showButton.setTitle("HIDE", for: .normal)
        }
        else{
            passwordTextField.isSecureTextEntry = true
            showButton.setTitle("SHOW", for: .normal)
        }
    }
    
    @IBAction func signUpButton(_ sender: Any) {
        guard let vcName = UIStoryboard(name: "SignUp", bundle: nil).instantiateViewController(identifier: "SignUpControlVC") as? SignUpControlVC else {return}
        
        self.navigationController?.pushViewController(vcName, animated: true)
        
        
    }
    
    @IBAction func logInButtonAction(_ sender: Any) {
        
        
        LogInService.shared.login(nickName: nickNameTextField.text!,
                                  password: passwordTextField.text!) {(networkResult) -> (Void) in
            switch networkResult {
            case .success(let data) :
                if let loginData = data as? LogInData{
                    print("로그인 성공")
                    UserDefaults.standard.set(loginData.token, forKey: "token")
                    guard let vcName = UIStoryboard(name: "UnderTab", bundle: nil).instantiateViewController(identifier: "UnderTabBarController") as? UINavigationController else {return}
                    vcName.modalPresentationStyle = .fullScreen
                    self.present(vcName, animated: true, completion: nil)
                    
                }
                
            case .requestErr(let msg):
                if let message = msg as? String {
                    print(message)
                }
            case .pathErr :
                print("pathErr")
            case .serverErr :
                print("serverErr")
            case .networkFail:
                print("networkFail")
                
                
                
            }
            
            
            
            
        }
        
    }
    
    
    
}


extension LogInVC {
    
    func setItems(){
        titleLabel.text = "매일 질문에 대한 답을 하며\n나를 알아가는 질문 다이어리 BeMe"
        titleLabel.font = UIFont(name: "AppleSDGothicNeo", size: 16)
        
        showButton.setTitleColor(.lightGray, for: .normal)
        showButton.setTitle("SHOW", for: .normal)
        
        nickNameTextField.setBorder(borderColor: .black, borderWidth: 1.0)
        passwordTextField.setBorder(borderColor: .black, borderWidth: 1.0)
        nickNameTextField.makeRounded(cornerRadius: 6)
        passwordTextField.makeRounded(cornerRadius: 6)
        logInButton.makeRounded(cornerRadius: 6)
        
        nickNameTextField.addLeftPadding(left: 7)
        passwordTextField.addLeftPadding(left: 7)
        
        nickNameTextField.delegate = self
        passwordTextField.delegate = self
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.view.endEditing(true)
        
        
    }
    
}

extension LogInVC: UITextFieldDelegate{
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        containViewHeight.constant = 105
        
        //        topConstraint.constant = 158
        UIView.animate(withDuration: 0.5, animations: {
            self.view.layoutIfNeeded()
        },completion: { finished in
            self.bemeLabel.alpha = 0
            
        })
        
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        containViewHeight.constant = 282
        //        topConstraint.constant = 108
        bemeLabel.alpha = 1.0
        UIView.animate(withDuration: 0.5, animations: {
            self.view.layoutIfNeeded()
        })
        
    }
    
    
}
