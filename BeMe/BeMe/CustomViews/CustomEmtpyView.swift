//
//  CustomEmtpyView.swift
//  BeMe
//
//  Created by Yunjae Kim on 2021/01/12.
//

import Foundation
import UIKit
import SnapKit


class CustomEmptyView: UIView {
    
    var emptyLabel = UILabel().then{
        $0.font = UIFont.systemFont(ofSize: 14)
        $0.textColor = .charcoalGrey
        $0.textAlignment = .center
        $0.numberOfLines = 0
    }
    var emptyImageView = UIImageView().then{
        $0.image = UIImage(named: "icInfo32")
    }
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
  
    func setItems(text: String){
        emptyLabel.text = text
        
        self.addSubview(emptyLabel)
        self.addSubview(emptyImageView)
        
        emptyLabel.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(32)
            
        }
        emptyImageView.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.width.height.equalTo(32)
            $0.top.equalToSuperview()
            
        }
        
    }
    
    func setImage(image: UIImage) {
        emptyImageView.image = image
        emptyImageView.snp.remakeConstraints{
            $0.centerX.equalToSuperview()
            $0.width.height.equalTo(44)
            $0.top.equalToSuperview()
        }
        emptyLabel.snp.remakeConstraints{
            $0.centerX.equalToSuperview()
            $0.top.equalTo(emptyImageView.snp.bottomMargin).offset(10)
            
        }
        emptyLabel.font = UIFont.systemFont(ofSize: 12)
    }
   
    
}
