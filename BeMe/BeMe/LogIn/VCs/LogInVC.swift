//
//  LogInVC.swift
//  BeMe
//
//  Created by Yunjae Kim on 2021/01/05.
//

import UIKit
import Then
import SnapKit

class LogInVC: UIViewController {
    
    @IBOutlet weak var labelContainView: UIView!
    
    @IBOutlet weak var bemeLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var showButton: UIButton!
    
    @IBOutlet weak var containViewHeight: NSLayoutConstraint!
    @IBOutlet weak var nickNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var buttonStackView: UIStackView!
    @IBOutlet weak var logInButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var warningImageView: UIImageView!
    @IBOutlet weak var warningLabel: UILabel!
    
    var blackParticles = 0
    var endTimer : Timer?
    var blackView = UIView().then{
        $0.backgroundColor = .black
        
    }
    let deviceBound = UIScreen.main.bounds.height/812.0
    
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
        
        self.view.endEditing(true)
        LogInService.shared.login(nickName: nickNameTextField.text!,
                                  password: passwordTextField.text!) {(networkResult) -> (Void) in
            switch networkResult {
            case .success(let data) :
                if let loginData = data as? LogInData{
                    print("로그인 성공")
                    UserDefaults.standard.set(loginData.token, forKey: "token")
                    UserDefaults.standard.set(self.nickNameTextField.text!,forKey: "nickName")
                    print(UserDefaults.standard.string(forKey: "nickName")!)
                    self.endAnimation2()
                    self.warningLabel.alpha = 0
                    self.warningImageView.alpha = 0
                   
                    
                }
                
            case .requestErr(let msg):
                if let message = msg as? String {
                    if message == "존재하지않는 유저 id 입니다."{
                        self.warningLabel.text = "해당하는 닉네임으로 된 계정이 없습니다"
                        self.warningLabel.alpha = 1
                        self.warningImageView.alpha = 1
                    }
                    else {
                        self.warningLabel.text = message
                        self.warningLabel.alpha = 1
                        self.warningImageView.alpha = 1
                        
                    }
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
        warningLabel.textColor = .grapefruit
        warningImageView.image = UIImage(named: "icInfoRed")
        warningLabel.alpha = 0
        warningImageView.alpha = 0
        
//        if deviceBound < 1 {
            containViewHeight.constant = 282*deviceBound
//        }
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.view.endEditing(true)
        
        
    }
    
    @objc func timerCallback(){
        blackParticles = blackParticles + 1
        let x = Int.random(in: Int(-view.frame.width/2)...Int(view.frame.width/2))
        let y = Int.random(in: Int(-view.frame.height/2)...Int(view.frame.height/2))
        var blackParticle = UIView().then{
            $0.backgroundColor = .black
            $0.makeRounded(cornerRadius: 250)
            $0.alpha = 0
        }
        self.view.addSubview(blackParticle)
        blackParticle.snp.makeConstraints{
            $0.width.height.equalTo(500)
            $0.centerX.equalToSuperview().offset(x)
            $0.top.equalToSuperview().offset(y)
        }
        let smaller = CGAffineTransform(scaleX: 0, y: 0)
        blackParticle.transform = smaller
        
        UIView.animate(withDuration: 2.0, animations: {
            blackParticle.alpha = 1
            blackParticle.transform = .identity
        })
        
        if blackParticles>10 {
            endTimer?.invalidate()
        }
        
    }
    func endAnimation(){
        endTimer = Timer.scheduledTimer(timeInterval: Double(2/Double(10)),
                                        target: self,
                                        selector: #selector(timerCallback),
                                        userInfo: nil,
                                        repeats: true)
        UIView.animate(withDuration: 1.0, delay: 2.0, animations: {
            self.view.backgroundColor = .black
            self.labelContainView.backgroundColor = .black
            
        }, completion: { finished in
            guard let vcName = UIStoryboard(name: "UnderTab", bundle: nil).instantiateViewController(identifier: "UnderTabBarController") as? UINavigationController else {return}
            vcName.modalPresentationStyle = .fullScreen
            self.present(vcName, animated: false, completion: nil)
        
        })
        
        
    }
    
    func endAnimation2(){
        
        UIView.animate(withDuration: 0.5, animations: {
            self.labelContainView.alpha = 0
            self.nickNameTextField.alpha = 0
            self.passwordTextField.alpha = 0
            self.logInButton.alpha = 0
            self.buttonStackView.alpha = 0
            self.showButton.alpha = 0
            
        }, completion: { f in
            
            UIView.animate(withDuration: 1.0, animations: {
                self.view.backgroundColor = .black
            },completion: { f in
                guard let vcName = UIStoryboard(name: "UnderTab", bundle: nil).instantiateViewController(identifier: "UnderTabBarController") as? UINavigationController else {return}
                vcName.modalPresentationStyle = .fullScreen
                self.present(vcName, animated: false, completion: nil)
            
                
            })
        })
        
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
        containViewHeight.constant = 282*deviceBound
        //        topConstraint.constant = 108
        bemeLabel.alpha = 1.0
        UIView.animate(withDuration: 0.5, animations: {
            self.view.layoutIfNeeded()
        })
        
    }
    
    
}
