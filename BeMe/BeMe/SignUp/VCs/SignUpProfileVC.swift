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
    
    @IBOutlet weak var imageContainView: UIView!
    @IBOutlet weak var addPhotoImage: UIImageView!
    @IBOutlet weak var finishButton: UIButton!
    var chosenImage: UIImage?
    @IBOutlet weak var jumpButton: UIButton!
    var myName: String?
    var myEmail: String?
    var myPassword: String?
    let cropSegue = "profileToCropSegue"
    
    lazy var imagePickerController = UIImagePickerController().then {
        $0.sourceType = .photoLibrary
        //        $0.allowsEditing = true
        $0.delegate = self
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setItems()
        
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func finishButtonAction(_ sender: Any) {
        LoadingHUD.show(loadingFrame: self.view.frame,color: .white)
        SignUpService.shared.signUp(email: myEmail!,nickName: myName!, password: myPassword!,
                                    image: profileImageView.image!,completion: { networkResult -> Void in
                                        switch networkResult {
                                        case .success(let data):
                                            if let signupData = data as? SignUpData{
                                                print("회원가입 성공")
                                                UserDefaults.standard.set(signupData.nickname, forKey: "nickName")
                                                
                                                LogInService.shared.login(nickName: self.myName!,
                                                                          password: self.myPassword!) {(networkResult) -> (Void) in
                                                    switch networkResult {
                                                    case .success(let data) :
                                                        if let loginData = data as? LogInData{
                                                            print("회원가입 후 로그인 성공")
                                                            UserDefaults.standard.set(loginData.token, forKey: "token")
                                                            print(UserDefaults.standard.string(forKey: "nickName")!)
                                                            self.dismiss(animated: false, completion: {
                                                                guard let vcName = UIStoryboard(name: "UnderTab", bundle: nil).instantiateViewController(identifier: "UnderTabBarController") as? UINavigationController else {return}
                                                                vcName.modalPresentationStyle = .fullScreen
                                                                self.present(vcName, animated: false, completion: {
                                                                    
                                                                })

                                                                
                                                            })
                                                            
                                                            
                                                        }
                                                        
                                                    case .requestErr(let msg):
                                                        if let message = msg as? String {
                                                            print(message)
                                                            LoadingHUD.hide()
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
        profileImageView.makeRounded(cornerRadius: 6)
        profileImageView.contentMode = .scaleAspectFill
        
        profileImageView.isUserInteractionEnabled = true
        let tabGesture = UITapGestureRecognizer(target: self, action: #selector(touchUpProfileImageView))
        profileImageView.addGestureRecognizer(tabGesture)
        imageContainView.makeRounded(cornerRadius: 6)
        imageContainView.setBorder(borderColor: .black, borderWidth: 1.0)
        
    }
    
    func setNickname(nickName: String){
        nickNameLabel.text = nickName
    }
    
    @objc func touchUpProfileImageView(){
        self.present(self.imagePickerController, animated: true, completion: nil)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //        if let cropViewController = segue.destination as?
        //            SignUpCropVC,
        //            segue.identifier == cropSegue {
        //            cropViewController.initialImage = chosenImage
        //         }
    }
    
}
extension SignUpProfileVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        chosenImage = info[.originalImage] as? UIImage
        let shittyVC = ShittyImageCropVC(frame: (self.navigationController?.view.frame)!, image: chosenImage!, aspectWidth: 315, aspectHeight: 152)
        shittyVC.signUpProfileImageSetDelegate = self
        self.dismiss(animated: true, completion: {
            self.navigationController?.present(shittyVC, animated: true, completion: nil)
        })
        addPhotoImage.alpha = 0
    }
    
    
    
}

extension SignUpProfileVC: SignUpProfileImageSetDelegate{
    func setImage(img: UIImage) {
        profileImageView.image = img
    }
}



protocol SignUpProfileImageSetDelegate {
    func setImage(img: UIImage)
}
