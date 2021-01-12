//
//  SignUpNoticeVC.swift
//  BeMe
//
//  Created by Yunjae Kim on 2021/01/12.
//

import UIKit

class SignUpNoticeVC: UIViewController {
    
    @IBOutlet var brownishGreyLabels: [UILabel]!
    
    @IBOutlet var backGroundViews: [UIView]!
    

    @IBOutlet var darkGreyLabels: [UILabel]!
    
    
    @IBOutlet var slateGreyLabels: [UILabel]!
    
    @IBOutlet weak var okayButton: UIButton!
    @IBOutlet weak var longLabel: UILabel!
    var signUpNextButtonDelegate: SignUpNextButtonDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        setItems()
        // Do any additional setup after loading the view.
    }
    

    
    func setItems(){
        longLabel.text = "해당 기능을 이용할 때 동의를 받고 있으며, 동의하지 않아도\n서비스의 이용이 가능합니다.\n마이페이지 > 설정 > 접근 권한 설정에서 해당 권한의 설정 변경이 가능합니다."
        
        for label in brownishGreyLabels{
            label.textColor = .brownishGrey
        }
        for label in slateGreyLabels {
            label.textColor = .slateGrey
        }
        for label in darkGreyLabels{
            label.textColor = .darkGrey
        }
        for view in backGroundViews {
            view.backgroundColor = .veryLightPinkThree
        }
        okayButton.makeRounded(cornerRadius: 6)
        
        
    }
    
    
    @IBAction func okayButtonAction(_ sender: Any) {
        
        signUpNextButtonDelegate?.nextButtonTapped(email: "", nickName: "", password: "")
    }
    
    
    
    
    
    

}
