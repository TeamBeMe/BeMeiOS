//
//  SignUpAgreeVC.swift
//  BeMe
//
//  Created by Yunjae Kim on 2021/01/12.
//

import UIKit

class SignUpAgreeVC: UIViewController {

    
    @IBOutlet var checkBoxes: [UIImageView]!
    
    @IBOutlet var mustLabels: [UILabel]!
    
    @IBOutlet var textViews: [UITextView]!
    @IBOutlet weak var okayButton: UIButton!
    var isChecked = [false,false]
    var signUpNextButtonDelegate: SignUpNextButtonDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        setItems()
        // Do any additional setup after loading the view.
    }

    func setItems(){
        for box in checkBoxes {
            box.image = UIImage(named: "btnCheckBoxBlank")
            box.isUserInteractionEnabled = true
        }
        for label in mustLabels {
            label.textColor = .deepSkyBlue
        }
        for textView in textViews {
            textView.backgroundColor = .veryLightPinkThree
            textView.textColor = .slateGrey
            textView.contentInset = UIEdgeInsets(top: 18, left: 30, bottom: 12, right: 30)
            textView.isEditable = false
        }
        let firstTabGesture = UITapGestureRecognizer(target: self, action: #selector(firstCheckBoxTapped))
        checkBoxes[0].addGestureRecognizer(firstTabGesture)
        let secondTabGesture = UITapGestureRecognizer(target: self, action: #selector(secondCheckBoxTapped))
        checkBoxes[1].addGestureRecognizer(secondTabGesture)
        okayButton.backgroundColor = .veryLightPink
        textViews[0].text = "('https://www.notion.so/BeMe-cff469352e5c4039819e125cc3b886e6cc3b886e6'이하 'BeMe')은(는) 개인정보보호법에 따라 이용자의 개인정보 보호 및 권익을 보호하고 개인정보와 관련한 이용자의 고충을 원활하게 처리할 수 있도록 다음과 같은 처리방침을 두고 있습니다.\n"


        
    }
    
    @objc func firstCheckBoxTapped(){
        if isChecked[0] == false{
            checkBoxes[0].image = UIImage(named: "btnCheckBox")
            isChecked[0] = true
            if isChecked[0] && isChecked[1] {
                UIView.animate(withDuration: 0.5, animations: {
                    self.okayButton.backgroundColor = .black
                })
               
            }
        }
        else{
            checkBoxes[0].image = UIImage(named: "btnCheckBoxBlank")
            isChecked[0] = false
            okayButton.backgroundColor = .veryLightPink
        }
        
    }
    @objc func secondCheckBoxTapped(){
        if isChecked[1] == false{
            checkBoxes[1].image = UIImage(named: "btnCheckBox")
            isChecked[1] = true
            if isChecked[0] && isChecked[1] {
                UIView.animate(withDuration: 0.5, animations: {
                    self.okayButton.backgroundColor = .black
                })
               
            }
        }
        else{
            checkBoxes[1].image = UIImage(named: "btnCheckBoxBlank")
            isChecked[1] = false
            okayButton.backgroundColor = .veryLightPink
        }
        
    }
    
    
    @IBAction func okayButtonAction(_ sender: Any) {
        if isChecked[0] && isChecked[1] {
            signUpNextButtonDelegate?.nextButtonTapped(email: "", nickName: "", password: "")
        }
        
    }
    
    

    
}
