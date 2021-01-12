//
//  OnboardingFirstVC.swift
//  BeMe
//
//  Created by Yunjae Kim on 2021/01/13.
//

import UIKit

class OnboardingFirstVC: UIViewController {
    
    
    @IBOutlet weak var imageContainView: UIView!
    
    @IBOutlet weak var detailLabel: UILabel!
    
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    var onboardingDelegate: OnboardingDelegate?
    
    let deviceBound = UIScreen.main.bounds.height/812.0
    
    let onboardingImageView = UIImageView().then {
        $0.image = UIImage(named: "onboarding01")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setItems()
        // Do any additional setup after loading the view.
    }
    

    func setItems(){
        detailLabel.textColor = .charcoalGrey
        detailLabel.text = "나는 어떤 사람인가요?\n내게 가장 소중한 것은 무엇인가요?\n내 삶의 목적은 무엇인가요?"
        topConstraint.constant = topConstraint.constant*deviceBound*deviceBound
        bottomConstraint.constant = bottomConstraint.constant*deviceBound
        heightConstraint.constant = heightConstraint.constant*deviceBound
        setImage()
    }
    
    func setImage(){
        imageContainView.backgroundColor = .systemBackground
        imageContainView.addSubview(onboardingImageView)
        onboardingImageView.snp.makeConstraints{
            $0.top.leading.bottom.trailing.equalToSuperview()
        }
        
        
    }
   
    

}
