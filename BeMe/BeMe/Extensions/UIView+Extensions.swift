//
//  UIView+Extensions.swift
//  BeMe
//
//  Created by Yunjae Kim on 2020/12/28.
//

import UIKit

extension UIView {
    
    // Set Rounded View
    func makeRounded(cornerRadius : CGFloat?){
        
        // UIView 의 모서리가 둥근 정도를 설정
        if let cornerRadius_ = cornerRadius {
            self.layer.cornerRadius = cornerRadius_
        }  else {
            // cornerRadius 가 nil 일 경우의 default
            self.layer.cornerRadius = self.layer.frame.height / 2
        }
        
        self.layer.masksToBounds = true
    }
    
    // Set UIView's Shadow
    func dropShadow(color: UIColor, offSet: CGSize, opacity: Float, radius: CGFloat) {
        
        // 그림자 색상 설정
        layer.shadowColor = color.cgColor
        // 그림자 크기 설정
        layer.shadowOffset = offSet
        // 그림자 투명도 설정
        layer.shadowOpacity = opacity
        // 그림자의 blur 설정
        layer.shadowRadius = radius
        // 구글링 해보세요!
        layer.masksToBounds = false
        
    }
    
    // Set UIView's Border
    func setBorder(borderColor : UIColor?, borderWidth : CGFloat?) {
        
        // UIView 의 테두리 색상 설정
        if let borderColor_ = borderColor {
            self.layer.borderColor = borderColor_.cgColor
        } else {
            // borderColor 변수가 nil 일 경우의 default
            self.layer.borderColor = UIColor(red: 205/255, green: 209/255, blue: 208/255, alpha: 1.0).cgColor
        }
        
        // UIView 의 테두리 두께 설정
        if let borderWidth_ = borderWidth {
            self.layer.borderWidth = borderWidth_
        } else {
            // borderWidth 변수가 nil 일 경우의 default
            self.layer.borderWidth = 1.0
        }
    }
    
    // 테두리와 모서리 둥글게 만드는 method
    func setBorderWithRadius(borderColor: UIColor?, borderWidth: CGFloat?, cornerRadius: CGFloat?) {
        if let bc = borderColor, let bw = borderWidth {
            self.layer.borderWidth = bw
            self.layer.borderColor = bc.cgColor
        }
        
        if let cr = cornerRadius {
            self.layer.cornerRadius = cr
        }
    }
    
    // 일부 모서리 테두리만 둥글게 만드는 method
    func roundCorners(cornerRadius: Double) {
        self.layer.cornerRadius = CGFloat(cornerRadius)
        self.clipsToBounds = true
        self.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    
    // 배경 어둡게 만들기
    func setPopupBackgroundView(to superV: UIView) {
        self.backgroundColor = .black
        superV.addSubview(self)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.topAnchor.constraint(equalTo: superV.topAnchor, constant: 0).isActive = true
        self.bottomAnchor.constraint(equalTo: superV.bottomAnchor, constant: 0).isActive = true
        self.leftAnchor.constraint(equalTo: superV.leftAnchor, constant: 0).isActive = true
        self.rightAnchor.constraint(equalTo: superV.rightAnchor, constant: 0).isActive = true
        self.isHidden = true
        self.alpha = 0
        superV.bringSubviewToFront(self)
    }
    
    func animatePopupBackground(_ direction: Bool) {
        let duration: TimeInterval = direction ? 0.35 : 0.20
        let alpha: CGFloat = direction ? 0.40 : 0.0
        self.isHidden = !direction
        UIView.animate(withDuration: duration) {
            self.alpha = alpha
        }
    }
    
    // 특정 모서리만 둥글게
    func roundCorners(cornerRadius: CGFloat, maskedCorners: CACornerMask) {
           clipsToBounds = true
           layer.cornerRadius = cornerRadius
           layer.maskedCorners = CACornerMask(arrayLiteral: maskedCorners)
       }
}
