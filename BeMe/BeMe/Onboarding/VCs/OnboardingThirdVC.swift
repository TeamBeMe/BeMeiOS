//
//  OnboardingThirdVC.swift
//  BeMe
//
//  Created by Yunjae Kim on 2021/01/13.
//

import UIKit

class OnboardingThirdVC: UIViewController {
    
    
    @IBOutlet weak var imageContainView: UIView!
    @IBOutlet weak var detailLabel: UILabel!
    
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    var onboardingDelegate: OnboardingDelegate?
    let deviceBound = UIScreen.main.bounds.height/812.0
    let onboardingImageView = UIImageView().then {
        $0.image = UIImage(named: "onboarding03")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setItems()
        // Do any additional setup after loading the view.
    }
    

    func setItems(){
        detailLabel.textColor = .charcoalGrey
        detailLabel.text = "내가 받은 질문에 다른 사람들은\n어떻게 생각하는지 볼 수 있어요\n내가 원한다면\n글을 공개하여 사람들과 소통할 수 있어요"
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
