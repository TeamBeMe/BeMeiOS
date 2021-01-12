//
//  CustomLoadingView.swift
//  BeMe
//
//  Created by Yunjae Kim on 2021/01/11.
//

import Foundation
import UIKit
import Lottie
import SnapKit

class LoadingHUD {
    private static let sharedInstance = LoadingHUD()
    
    private var backgroundView: UIView?
    private var popupView: UIImageView?
    private var loadingLabel: UILabel?
    private var animationView: AnimationView?
    
    class func show(loadingFrame: CGRect,color: UIColor) {
        let backgroundView = UIView(frame: loadingFrame)
        
        
        let animationView = AnimationView()
        animationView.frame = CGRect.init(x: 0, y: 0, width: 100, height: 100)
        //어떤 jsonv파일을 쓸지
        animationView.animation = Animation.named("loading")
        //화면에 적합하게
        animationView.contentMode = .scaleAspectFit
        //반복되게
        animationView.loopMode = .loop
        //실행
       
        //view안에 Subview로 넣어준다,
       
        
        if let window = UIApplication.shared.keyWindow {
            window.addSubview(backgroundView)
            backgroundView.addSubview(animationView)
          
            
            backgroundView.frame = loadingFrame
            backgroundView.backgroundColor = color
            
//            animationView.frame = CGRect.init(x: 0, y: 0, width: 100, height: 100)
            animationView.snp.makeConstraints{
                $0.center.equalToSuperview()
                $0.width.height.equalTo(100)
            }
            animationView.play()
            
          
            
            sharedInstance.backgroundView?.removeFromSuperview()
            sharedInstance.animationView?.removeFromSuperview()
           
            sharedInstance.backgroundView = backgroundView
            sharedInstance.animationView = animationView
            
        }
    }
    
    class func hide() {
        if let animationView = sharedInstance.animationView,
        let backgroundView = sharedInstance.backgroundView {
            animationView.stop()
            backgroundView.removeFromSuperview()
            animationView.removeFromSuperview()
        }
    }
}
