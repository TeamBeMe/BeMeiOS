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
