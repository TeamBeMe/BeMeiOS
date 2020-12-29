//
//  AddCardCVC.swift
//  BeMe
//
//  Created by Yunjae Kim on 2020/12/28.
//

import UIKit

class AddCardCVC: UICollectionViewCell {
    static let identifier : String = "AddCardCVC"
    
    //MARK:- IBOutlets

    var questionLabel = UILabel().then {
        $0.text = "송현님, 나를 더 알아보기\n위한 다른 질문이 준비되어 있어요."
        $0.font = UIFont.systemFont(ofSize: 18)
        $0.textColor = .white
        $0.textAlignment = .center
        $0.numberOfLines = 0
    }

    var addButton = UIButton().then {
        $0.setTitle("새로운 질문 받기", for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        $0.backgroundColor = .white
        $0.makeRounded(cornerRadius: 6)
        $0.setTitleColor(.black, for: .normal)
        $0.addTarget(self, action: #selector(addButtonAction), for: .touchUpInside)
    }
    
    var addDelegate : AddQuestionDelegate?

}

//MARK:- LifeCycle Methods
extension AddCardCVC {
    
    override func awakeFromNib() {
        makeQuestionLabel()
        makeAddButton()
        self.contentView.backgroundColor = UIColor(cgColor: CGColor(red: 44/255, green: 44/255, blue: 46/255, alpha: 1.0))
        self.makeRounded(cornerRadius: 6)
        
    }
    
    
    
}


//MARK:- Setting AutoLayout
extension AddCardCVC {
    

    func makeQuestionLabel(){
        self.addSubview(questionLabel)
        questionLabel.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(162)
        }
    }
    func makeAddButton(){
        self.addSubview(addButton)
        addButton.snp.makeConstraints{
            $0.leading.equalToSuperview().offset(32)
            $0.trailing.equalToSuperview().offset(-32)
            $0.top.equalToSuperview().offset(379)
            $0.height.equalTo(50)
        }
    }

}


//MARK:- User Define Functions
extension AddCardCVC {
    
    @objc func addButtonAction(){
        print("called") 
//        addDelegate?.addQuestion()
        
        
        
    }
    
    
    
}
