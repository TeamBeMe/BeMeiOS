//
//  HomeLottietestVC.swift
//  BeMe
//
//  Created by Yunjae Kim on 2021/01/09.
//

import UIKit
import Lottie
class HomeLottietestVC: UIViewController {
    
    let animationView = AnimationView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        // Do any additional setup after loading the view.
    }
    
    func setup(){
        //animationView 크기가 view와 같게
        animationView.frame = view.bounds
        //어떤 jsonv파일을 쓸지
        animationView.animation = Animation.named("loading")
        //화면에 적합하게
        animationView.contentMode = .scaleAspectFit
        //반복되게
        animationView.loopMode = .loop
        //실행
        animationView.play()
        //view안에 Subview로 넣어준다,
        view.addSubview(animationView)
    }
    
    
    
}
