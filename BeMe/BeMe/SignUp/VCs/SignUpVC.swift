//
//  SignUpVC.swift
//  BeMe
//
//  Created by Yunjae Kim on 2021/01/05.
//

import UIKit

class SignUpVC: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var nickNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordCheckTextField: UITextField!
    
    @IBOutlet weak var signUpScrollView: UIScrollView!
    @IBOutlet weak var nickNameCheckButton: UIButton!
    @IBOutlet weak var finishButton: UIButton!
    
    
    @IBOutlet var textFields: [UITextField]!
    var textFieldIsValid = [true,false,false,false]
    
    @IBOutlet var warningImageViews: [UIImageView]!
    @IBOutlet var warningLabels: [UILabel]!
    var car: Int?
    var signUpNextButtonDelegate: SignUpNextButtonDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        setItems()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillLayoutSubviews() {
        var flag = true
        for v in textFieldIsValid{
            if v == false{
                flag = false
            }
            
        }
        if flag == true{
            UIView.animate(withDuration: 0.5, animations: {
                self.finishButton.backgroundColor = .black
            })
            
        }
        else{
            UIView.animate(withDuration: 0.5, animations: {
                self.finishButton.backgroundColor = .lightGray
            })
        }
    }
    
    
    @IBAction func nickNameCheckButtonAction(_ sender: Any) {
        if nickNameTextField.text!.isValidNickName(){
            SignUpDuplicateService.shared.check(nickName: nickNameTextField.text!){(networkResult) -> (Void) in
                switch networkResult{
                case .success(let data) :
                    if let dup = data as? SignUpDuplicateData{
                        if dup.nicknameExist == false{
                            self.warningLabels[1].text = "사용 가능한 닉네임입니다"
                            self.warningImageViews[1].image = UIImage(named: "icDone")
                            self.warningLabels[1].textColor = UIColor(red: 10.0/255.0, green: 132.0/255.0
                                                                 , blue: 255.0/255.0, alpha: 1.0)
                            self.textFieldIsValid[1] = true
                        }
                        else{
                            self.warningImageViews[1].image = UIImage(named: "icInfoRed")
                            self.warningLabels[1].text = "다른 닉네임을 입력해주세요"
                            self.warningLabels[1].textColor = .red
                            self.textFieldIsValid[1] = false
                        }
                        
                    }
                    
                    print("success")
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
        else{
            print("called")
            warningImageViews[1].image = UIImage(named: "icInfoRed")
            warningLabels[1].text = "다른 닉네임을 입력해주세요"
            warningLabels[1].textColor = .red
            textFieldIsValid[1] = false
        }
        
    }
    
    
    @IBAction func finishButtonAction(_ sender: Any) {
       
        self.isEditing = false
        var flag = true
        for v in textFieldIsValid{
            if v == false{
                flag = false
            }
            
        }
        if flag == true{
            signUpNextButtonDelegate?.nextButtonTapped(email: emailTextField.text!,
                                                       nickName: nickNameTextField.text!,
                                                       password: passwordTextField.text!)
            let move = CGPoint(x: 0, y: 0)
            signUpScrollView.setContentOffset(move, animated: false)
            
        }
        
    }
    

}



//MARK:- User Define Functions
extension SignUpVC{
    
    func setItems(){
        titleLabel.text = "매일 질문에 대한\n답을 하며\n나를 더 알아갈 수 있어요"
        setTextFields()
        finishButton.setTitleColor(.white, for: .normal)
        finishButton.backgroundColor = .lightGray
        finishButton.makeRounded(cornerRadius: 6)
        
        setWarnings()
    }
    
    func setTextFields(){
        
        for tf in textFields {
            tf.setBorder(borderColor: .black, borderWidth: 1.0)
            tf.makeRounded(cornerRadius: 6)
            tf.addLeftPadding(left: 7)
            tf.delegate = self
            
        }
        textFields[3].addTarget(self, action: #selector(comparePasswords), for: .editingChanged)
        
    }
    
    func setWarnings(){
        
        warningImageViews[0].alpha = 0
        warningLabels[0].alpha = 0
        
        warningImageViews[1].image = UIImage(named: "icInfoGrey")
        warningLabels[1].text = "영문,숫자 20자 이내로 입력해주세요"
        warningLabels[1].textColor = .lightGray
        
        warningImageViews[2].image = UIImage(named: "icInfoGrey")
        warningLabels[2].text = "비밀번호는 영문,숫자로 8자 이상 입력해주세요"
        warningLabels[2].textColor = .lightGray
        
        warningImageViews[3].alpha = 0
        warningLabels[3].alpha = 0
        
        
    }
    
    @objc func comparePasswords(){
        if passwordTextField.text! != passwordCheckTextField.text!
            && passwordTextField.text!.isValidPassword(){
            warningImageViews[3].alpha = 1
            warningLabels[3].alpha = 1
            warningLabels[3].text = "비밀번호가 일치하지 않습니다."
            warningImageViews[3].image = UIImage(named: "icInfoRed")
            warningLabels[3].textColor = .red
            textFieldIsValid[3] = false
        }
        else if passwordTextField.text != "" && passwordTextField.text!.isValidPassword(){
            warningImageViews[3].alpha = 1
            warningLabels[3].alpha = 1
            warningLabels[3].text = "비밀번호가 일치합니다."
            warningImageViews[3].image = UIImage(named: "icDone")
            warningLabels[3].textColor = UIColor(red: 10.0/255.0, green: 132.0/255.0
                                                  , blue: 255.0/255.0, alpha: 1.0)
            textFieldIsValid[3] = true
        }
    
    }
    
   
    
}


extension SignUpVC: UITextFieldDelegate{
    func textFieldDidBeginEditing(_ textField: UITextField) {
        switch textField {
        case emailTextField:
            let move = CGPoint(x: 0, y: 0)
            UIView.animate(withDuration: 0.5, delay : 0.3, animations: {
                
                self.signUpScrollView.setContentOffset(move, animated: false)
            })
        case nickNameTextField:
            let move = CGPoint(x: 0, y: 92)
            UIView.animate(withDuration: 0.5, delay : 0.3, animations: {
                
                self.signUpScrollView.setContentOffset(move, animated: false)
            })
        case passwordTextField:
            let move = CGPoint(x: 0, y: 184)
            UIView.animate(withDuration: 0.5, delay : 0.3, animations: {
                
                self.signUpScrollView.setContentOffset(move, animated: false)
            })
        case passwordCheckTextField:
            let move = CGPoint(x: 0, y: 250)
            UIView.animate(withDuration: 0.5, delay : 0.3, animations: {
                
                self.signUpScrollView.setContentOffset(move, animated: false)
            })
        default:
            return
        }
        
        
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField {
//        case emailTextField:
           
//        case nickNameTextField:
           
        
        case passwordTextField:
            if passwordTextField.text!.isValidPassword(){
                warningLabels[2].text = "사용 가능한 비밀번호입니다"
                textFieldIsValid[2] = true
                warningImageViews[2].image = UIImage(named: "icDone")
                warningLabels[2].textColor = UIColor(red: 10.0/255.0, green: 132.0/255.0
                                                     , blue: 255.0/255.0, alpha: 1.0)
                
            }
            else{
                warningLabels[2].text = "8자 이상 20자 이내인 영문과 숫자의 조합이어야 합니다."
                warningImageViews[2].image = UIImage(named: "icInfoRed")
                textFieldIsValid[2] = false
                warningLabels[2].textColor = .red
                
            }
            
        default:
            return
        }
        
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if textField == nickNameTextField{
            let newLength = (textField.text?.count)! + string.count - range.length
            return !(newLength > 20)
        }
        
        return true
    }
    
    
}
