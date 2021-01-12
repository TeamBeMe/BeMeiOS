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
