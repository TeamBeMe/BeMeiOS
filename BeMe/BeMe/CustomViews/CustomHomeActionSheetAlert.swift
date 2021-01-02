//
//  CustomActionSheetAlert.swift
//  BeMe
//
//  Created by Yunjae Kim on 2021/01/02.
//

import Foundation
import UIKit

class CustomHomeActionSheetAlert : UIView {
    
    var firstImage = UIImageView().then {
        $0.image = UIImage(named: "icEdit")
        
    }
    var firstLabel = UILabel().then {
        $0.text = "수정하기"
        $0.textColor = .white
        $0.font = UIFont.systemFont(ofSize: 15)
    }
    
    var secondImage = UIImageView().then {
        $0.image = UIImage(named: "icDelete")
    }
    var secondLabel = UILabel().then {
        $0.text = "삭제하기"
        $0.textColor = .grapefruit
        $0.font = UIFont.systemFont(ofSize: 15)
    }
    var lineView = UIView().then {
        $0.backgroundColor = .slateGrey
    }
    var cancelButton = UIButton().then {
        $0.setTitle("취소", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 16)
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .charcoalGrey
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}


// MARK:- make item functions
extension CustomHomeActionSheetAlert {
    
    func makeFirstImage(){
        self.addSubview(firstImage)
        firstImage.snp.makeConstraints{
            $0.leading.equalToSuperview().offset(22)
            $0.top.equalToSuperview().offset(15)
            $0.width.height.equalTo(32)
        }
        
    }
    func makeFirstLabel(){
        self.addSubview(firstLabel)
        firstLabel.snp.makeConstraints{
            $0.leading.equalToSuperview().offset(69)
            $0.top.equalToSuperview().offset(23)
        }
        
        
    }
    func makeSecondImage(){
        self.addSubview(secondImage)
        secondImage.snp.makeConstraints{
            $0.leading.equalToSuperview().offset(22)
            $0.top.equalToSuperview().offset(67)
            $0.width.height.equalTo(32)
        }
        
    }
    func makeSecondLabel(){
        self.addSubview(firstLabel)
        secondLabel.snp.makeConstraints{
            $0.leading.equalToSuperview().offset(69)
            $0.top.equalToSuperview().offset(75)
        }
        
    }
    func makeLineView(){
        self.addSubview(lineView)
        lineView.snp.makeConstraints{
            $0.bottom.equalToSuperview().offset(-82.5)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(1)
        }
        
    }
    func makeCancelButton(){
        self.addSubview(cancelButton)
        firstLabel.snp.makeConstraints{
            $0.leading.equalToSuperview().offset(69)
            $0.top.equalToSuperview().offset(23)
        }
    }
    
    
    
}
