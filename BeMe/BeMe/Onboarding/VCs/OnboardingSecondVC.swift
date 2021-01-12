//
//  OnboardingSecondVC.swift
//  BeMe
//
//  Created by Yunjae Kim on 2021/01/13.
//

import UIKit

class OnboardingSecondVC: UIViewController {
    
    let deviceBound = UIScreen.main.bounds.height/812.0
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageContainView: UIView!
    @IBOutlet weak var detailLabel: UILabel!
    
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    
    var onboardingDelegate: OnboardingDelegate?
    let onboardingImageView = UIImageView().then {
        $0.image = UIImage(named: "onboarding02")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setItems()
        // Do any additional setup after loading the view.
    }
    

    func setItems(){
        detailLabel.textColor = .charcoalGrey
        detailLabel.text = "BeMe가 여러분께\n매일 10시 질문을 보내드릴게요\n질문에 답을 하면서 진정한 나를 찾을 수 있도록\n도와드릴게요"
        setImage()
        topConstraint.constant = topConstraint.constant*deviceBound*deviceBound
        bottomConstraint.constant = bottomConstraint.constant*deviceBound
        heightConstraint.constant = heightConstraint.constant*deviceBound
    }
    
    func setImage(){
        imageContainView.backgroundColor = .systemBackground
        imageContainView.addSubview(onboardingImageView)
        onboardingImageView.snp.makeConstraints{
            $0.top.leading.bottom.trailing.equalToSuperview()
        }
        
        
    }
   

}
