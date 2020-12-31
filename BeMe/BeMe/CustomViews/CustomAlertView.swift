//
//  CustomAlertView.swift
//  BeMe
//
//  Created by Yunjae Kim on 2020/12/29.
//

import UIKit

class CustomAlertView: UIView {

    
    let alertTitleLabel = UILabel().then {
        $0.text = "공개 질문으로 전환하시겠어요?"
        $0.textColor = .white
        $0.font = UIFont.systemFont(ofSize: 16)
        $0.numberOfLines = 0
    }
    let alertLeftButton = UIButton().then {
        $0.setTitle("취소", for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        $0.backgroundColor = UIColor(cgColor: CGColor(red: 30/255,
                                                      green: 30/255,
                                                      blue:30/255,
                                                      alpha: 1))
        $0.setTitleColor(.white, for: .normal)
        $0.addTarget(self, action: #selector(touchUpLeftButton), for: .touchUpInside)
    }
    let alertRightButton = UIButton().then {
        $0.setTitle("확인", for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        $0.backgroundColor = UIColor(cgColor: CGColor(red: 30/255,
                                                      green: 30/255,
                                                      blue:30/255,
                                                      alpha: 1))
        $0.setTitleColor(.systemBlue, for: .normal)
        $0.addTarget(self, action: #selector(touchUpRightButton), for: .touchUpInside)
    }
    
    let horizontalSeperator = UIView().then {
        $0.backgroundColor = .gray
    }
    let verticalSeperator = UIView().then {
        $0.backgroundColor = .gray
    }
    var leftButtonClicked: (()->())?
    var rightButtonClicked: (()->())?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor(cgColor: CGColor(red: 30/255,
                                                        green: 30/255,
                                                        blue:30/255,
                                                        alpha: 1))
        self.makeRounded(cornerRadius: 14)
        
        addViews()
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addViews(){
        self.addSubview(alertTitleLabel)
        self.addSubview(alertLeftButton)
        self.addSubview(alertRightButton)
        self.addSubview(horizontalSeperator)
        self.addSubview(verticalSeperator)


    }
    
    func addConstraints(){
        alertTitleLabel.snp.makeConstraints{
            $0.top.equalToSuperview().offset(30)
            $0.centerX.equalToSuperview()
        }
        alertLeftButton.snp.makeConstraints{
            $0.width.equalTo(135)
            $0.height.equalTo(44)
            $0.leading.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        alertRightButton.snp.makeConstraints{
            $0.width.equalTo(135)
            $0.height.equalTo(44)
            $0.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
            
        }
        horizontalSeperator.snp.makeConstraints{
            $0.top.equalToSuperview().offset(78)
            $0.height.equalTo(1)
            $0.width.equalToSuperview()
        }
        verticalSeperator.snp.makeConstraints{
            $0.top.equalToSuperview().offset(78)
            $0.width.equalTo(1)
            $0.height.equalTo(44)
            $0.centerX.equalToSuperview()
        }
        
    }
    
    func addLeftAction(action : Selector){
        alertLeftButton.addTarget(self, action: action, for: .touchUpInside)
        
        
    }
    
    func setTitles(titleLabel : String,
                   leftButtonTitle : String,
                   rightButtonTitle : String
                   ){
        alertTitleLabel.text = titleLabel
        alertLeftButton.setTitle(leftButtonTitle, for: .normal)
        alertRightButton.setTitle(rightButtonTitle, for: .normal)
    }
    
    func setUpperAuto(topConstraint : CGFloat) {
        alertTitleLabel.snp.remakeConstraints{
            $0.top.equalToSuperview().offset(topConstraint)
        }
        
    }
    
    func setBackgroundColor(color : UIColor, leftButtonTitleColor : UIColor){
        self.backgroundColor = color
        alertLeftButton.backgroundColor = color
        alertRightButton.backgroundColor = color
        alertLeftButton.setTitleColor(color, for: .normal)
        
    }
    
    
    
    @objc func touchUpLeftButton() {
        if let handler = leftButtonClicked {
            handler()
        }
    }
    
    @objc func touchUpRightButton() {
        if let handler = rightButtonClicked {
            handler()
        }
    }
    
    
}
