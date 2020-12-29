//
//  PastCardCVC.swift
//  BeMe
//
//  Created by Yunjae Kim on 2020/12/28.
//

import UIKit

class PastCardCVC: UICollectionViewCell {
    static let identifier : String = "PastCardCVC"
    
    //MARK:- IBOutlets
    var lockButton = UIButton().then {
        $0.setTitle("L", for: .normal)
        $0.setTitleColor(.white, for: .normal)
    }
    
    var questionInfoLabel = UILabel().then {
        $0.text = "[ 미래에 관한 2번째 질문 ] "
        $0.font = UIFont.systemFont(ofSize: 14)
        $0.textColor = .white
        $0.textAlignment = .center
    }
    var dateLabel = UILabel().then {
        $0.text = "2020. 12. 24"
        $0.font = UIFont.systemFont(ofSize: 14)
        $0.textColor = .white
        $0.textAlignment = .center
        
    }
    var questionLabel = UILabel().then {
        $0.text = "이번 주말을 후회 없이\n보낼 수 있는 방법은 무엇인가요?"
        $0.font = UIFont.systemFont(ofSize: 18)
        $0.textColor = .white
        $0.textAlignment = .center
        $0.numberOfLines = 0
    }
    var answerTextView = UITextView().then {
        $0.text = "저는 몇일 전 퇴사를 했어요. 수많은 고민 끝에 결국 저질렀습니다. 몇 년간 원해 왔던 일이라 꿈만 같아요. 제가 스스로의 힘으로 하고 싶은 걸 해볼 수있는 시간적 여유를 가지게 된게 정말 만족스러워요."
        $0.textColor = .white
//        $0.isEditable = false
        $0.font = UIFont.systemFont(ofSize: 14)
        $0.textAlignment = .center
        $0.backgroundColor = UIColor(cgColor: CGColor(red: 44/255, green: 44/255, blue: 46/255, alpha: 1.0))
            
    }
    
    
    
    //MARK:- User Define Variables
    
    var isPublic = false
    var changePublicDelegate : ChangePublicDelegate?

    
    
}


//MARK:- LifeCycle Methods
extension PastCardCVC {
    
    override func awakeFromNib() {
        makeLockButton()
        makeQuestionInfoLabel()
        makeDateLabel()
        makeQuestionLabel()
        makeAnswerTextView()
        self.makeRounded(cornerRadius: 6)
        self.contentView.backgroundColor = UIColor(cgColor: CGColor(red: 44/255, green: 44/255, blue: 46/255, alpha: 1.0))
        lockButton.addTarget(self, action: #selector(changePublic), for: .touchUpInside)
        
    }
    
    
    
}


//MARK:- Setting AutoLayout
extension PastCardCVC {
    
    func makeLockButton(){
        self.addSubview(lockButton)
        lockButton.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(40)
            $0.width.equalTo(12.6)
            $0.height.equalTo(18)
        }
    }
    
    func makeQuestionInfoLabel(){
        self.addSubview(questionInfoLabel)
        questionInfoLabel.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(77)
        }
    }
    
    func makeDateLabel(){
        self.addSubview(dateLabel)
        dateLabel.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(95)
        }
    }
    
    
    func makeQuestionLabel(){
        self.addSubview(questionLabel)
        questionLabel.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(162)
        }
    }
    
    func makeAnswerTextView(){
        self.addSubview(answerTextView)
        answerTextView.snp.makeConstraints{
            $0.leading.equalToSuperview().offset(40)
            $0.trailing.equalToSuperview().offset(-40)
            $0.top.equalToSuperview().offset(223)
            $0.height.equalTo(160)
        }
    }
    
    
    
    
}

//MARK:- User Define functions
extension PastCardCVC {
    
    @objc func changePublic(){

        changePublicDelegate?.changePublic(now: isPublic)
        
    }
    
    func setLock(after : Bool){
        if after == true {
            lockButton.setTitle("U", for: .normal)
            lockButton.setImage(UIImage(systemName: "lock.slash"), for: .normal)
            lockButton.tintColor = .white
        }
        else{
            lockButton.setTitle("L", for: .normal)
            lockButton.setImage(UIImage(systemName: "lock"), for: .normal)
            lockButton.tintColor = .white
        }
        
    }
    
    
    
    
}
