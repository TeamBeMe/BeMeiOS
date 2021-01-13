//
//  OnboardingFourthVC.swift
//  BeMe
//
//  Created by Yunjae Kim on 2021/01/13.
//

import UIKit

class OnboardingFourthVC: UIViewController {

    @IBOutlet weak var imageContainView: UIView!
    
    @IBOutlet weak var detailLabel: UILabel!
    
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    var onboardingDelegate: OnboardingDelegate?
    let deviceBound = UIScreen.main.bounds.height/812.0
    let onboardingImageView = UIImageView().then {
        $0.image = UIImage(named: "onboarding04")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setItems()
        // Do any additional setup after loading the view.
    }
    

    func setItems(){
        detailLabel.textColor = .charcoalGrey
        detailLabel.text = "1년 후 같은 질문에 답을 해보세요\n과거의 나는 어떻게 생각했는지, 내 생각이\n어떻게 변했는지 알아보세요"
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
