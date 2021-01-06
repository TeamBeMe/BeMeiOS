//
//  HomeVC+UnderAlert.swift
//  BeMe
//
//  Created by Yunjae Kim on 2021/01/02.
//

import Foundation
import UIKit
import SnapKit
import Then

extension HomeVC {
    
    func makeUnderAlertView(){
        view.addSubview(blurView)
        view.addSubview(alertContainView)
        
        blurView.snp.makeConstraints{
            $0.leading.bottom.top.trailing.equalToSuperview()
        }
        alertContainView.snp.makeConstraints{
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(204)
        }
        alertContainView.makeRounded(cornerRadius: 10)
        makeChangeButton()
        makeRemoveButton()
        makeFirstImage()
        makeFirstLabel()
        makeSecondImage()
        makeSecondLabel()
        makeLineView()
        makeCancelButton()
        makeCancelLabel()
        self.tabBarController?.tabBar.isHidden = true
        UIView.animate(withDuration: 0.5, animations: {
            
            
        })
        
    }
    
    func makeFirstImage(){
        alertContainView.addSubview(firstImage)
        firstImage.snp.makeConstraints{
            $0.leading.equalToSuperview().offset(22)
            $0.top.equalToSuperview().offset(15)
            $0.width.height.equalTo(32)
        }
        
    }
    func makeFirstLabel(){
        alertContainView.addSubview(firstLabel)
        firstLabel.snp.makeConstraints{
            $0.leading.equalToSuperview().offset(69)
            $0.top.equalToSuperview().offset(23)
        }
        
        
    }
    func makeSecondImage(){
        alertContainView.addSubview(secondImage)
        secondImage.snp.makeConstraints{
            $0.leading.equalToSuperview().offset(22)
            $0.top.equalToSuperview().offset(67)
            $0.width.height.equalTo(32)
        }
        
    }
    func makeSecondLabel(){
        alertContainView.addSubview(secondLabel)
        secondLabel.snp.makeConstraints{
            $0.leading.equalToSuperview().offset(69)
            $0.top.equalToSuperview().offset(75)
        }
        
    }
    func makeLineView(){
        alertContainView.addSubview(lineView)
        lineView.snp.makeConstraints{
            $0.bottom.equalToSuperview().offset(-82.5)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(1)
        }
        
    }
    func makeCancelButton(){
        alertContainView.addSubview(cancelButton)
        cancelButton.snp.makeConstraints{
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(82.5)
            $0.bottom.equalToSuperview()
        }
        cancelButton.addTarget(self,
                               action: #selector(underAlertCancelButtonAction),
                               for: .touchUpInside)
        
    }
    func makeCancelLabel(){
        alertContainView.addSubview(cancelLabel)
        cancelLabel.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-54)
        }
        
    }
    
    func makeChangeButton(){
        alertContainView.addSubview(changeButton)
        changeButton.snp.makeConstraints{
            $0.leading.trailing.top.equalToSuperview()
            $0.height.equalTo(57)
        }
        changeButton.addTarget(self, action: #selector(changeButtonAction), for: .touchUpInside)
    }
    
    func makeRemoveButton(){
        alertContainView.addSubview(changeButton)
        changeButton.snp.makeConstraints{
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(57)
            $0.top.equalToSuperview().offset(57)
        }
        
    }
    
    @objc func underAlertCancelButtonAction(){
        blurView.removeFromSuperview()
        alertContainView.removeFromSuperview()
        self.tabBarController?.tabBar.isHidden = false
        
    }
    
    @objc func changeButtonAction(){
        guard let answerVC = UIStoryboard(name: "Answer",
                                          bundle: nil).instantiateViewController(
                                              withIdentifier: "AnswerVC") as? AnswerVC
              else{
                  
                  return
          }
        answerVC.answerDataDelegate = self
       
        answerVC.answerData = answerDataList[currentCardIdx]
        answerVC.curCardIdx = currentCardIdx
        
        blurView.removeFromSuperview()
        alertContainView.removeFromSuperview()
        self.tabBarController?.tabBar.isHidden = false
        self.navigationController?.pushViewController(answerVC, animated: true)
        
        
        
    }
    
    
}
