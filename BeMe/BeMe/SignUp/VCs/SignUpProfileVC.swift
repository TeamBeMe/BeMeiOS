//
//  SingUpProfileVC.swift
//  BeMe
//
//  Created by Yunjae Kim on 2021/01/05.
//

import UIKit

class SignUpProfileVC: UIViewController {
    
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageSelectButton: UIButton!
    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet weak var nickNameLabel: UILabel!
    
    @IBOutlet weak var finishButton: UIButton!
    
    @IBOutlet weak var jumpButton: UIButton!
    var myName: String?
    var myEmail: String?
    var myPassword: String?
    
    
    lazy var imagePickerController = UIImagePickerController().then {
        $0.sourceType = .photoLibrary
        $0.allowsEditing = true
        $0.delegate = self
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setItems()

        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func finishButtonAction(_ sender: Any) {
        SignUpService.shared.signUp(email: myEmail!,nickName: myName!, password: myPassword!,image: profileImageView.image!,completion: { networkResult -> Void in
            switch networkResult {
            case .success(let data):
                if let signupData = data as? SignUpData{
                    print("회원가입 성공")
                    UserDefaults.standard.set(signupData.nickname, forKey: "nickName")
                    
                    
                }
            case .requestErr(let msg):
                if let message = msg as? String {
                    print(message)
                    print("회원가입 실패")
                }
            case .pathErr :
                print("pathErr")
            case .serverErr :
                print("serverERr")
            case .networkFail :
                print("networkFail")
            default :
                print("머지?")
            }
                                     
            
        
            
            
        })
        
    }
    
    
    @IBAction func jumpButtonAction(_ sender: Any) {
       
        
        
        
        
    }
    
    
}


extension SignUpProfileVC{
    func setItems(){
        titleLabel.text = "나를 대신하여\n표현할 수 있는\n사진을 선택해주세요"
        finishButton.backgroundColor = .black
        finishButton.setTitleColor(.white, for: .normal)
        jumpButton.setTitleColor(.black, for: .normal)
        
        finishButton.makeRounded(cornerRadius: 6)
        jumpButton.makeRounded(cornerRadius: 6)
        profileImageView.makeRounded(cornerRadius: 60)
        profileImageView.contentMode = .scaleToFill
        
        profileImageView.isUserInteractionEnabled = true
        let tabGesture = UITapGestureRecognizer(target: self, action: #selector(touchUpProfileImageView))
        profileImageView.addGestureRecognizer(tabGesture)
    }
    
    func setNickname(nickName: String){
        nickNameLabel.text = nickName
    }
    
    @objc func touchUpProfileImageView(){
        self.present(self.imagePickerController, animated: true, completion: nil)
    }
    
}
extension SignUpProfileVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let originalImage: UIImage = info[.originalImage] as? UIImage {
            self.profileImageView.image = originalImage
        }
        
        self.dismiss(animated: true, completion: nil)
    }
}