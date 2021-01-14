//
//  NewCardCVC.swift
//  BeMe
//
//  Created by Yunjae Kim on 2020/12/28.
//

import UIKit
import Then
import SnapKit
import Lottie
class NewCardCVC: UICollectionViewCell {
    static let identifier : String = "NewCardCVC"
    var answerData : AnswerDataForViewController?
    var index : Int?
    var isInitial = false
    var isAnimated = false
    //MARK:- IBOutlets
    var lockButton = UIButton().then {
        $0.setImage(UIImage(named: "btnLock")?.withRenderingMode(.alwaysOriginal), for: .normal)
    }
    
    var questionInfoLabel = UILabel().then {
        $0.text = "[ 미래에 관한 2번째 질문 ] "
        $0.font = UIFont.systemFont(ofSize: 14)
        $0.textColor = .slateGrey
        $0.textAlignment = .center
    }
    var dateLabel = UILabel().then {
        $0.text = "2020. 12. 24"
        $0.font = UIFont.systemFont(ofSize: 14)
        $0.textColor = .slateGrey
        $0.textAlignment = .center
        
    }
    var questionLabel = UILabel().then {
        $0.text = "이번 주말을 후회 없이\n보낼 수 있는 방법은 무엇인가요?"
        $0.font = UIFont.systemFont(ofSize: 18)
        $0.textColor = .white
        $0.textAlignment = .center
        $0.numberOfLines = 0
    }
    
    var replyButton = UIButton().then {
        $0.setTitle("답변하기", for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        $0.backgroundColor = .white
        $0.makeRounded(cornerRadius: 6)
        $0.setTitleColor(.black, for: .normal)
        
        
    }
    
    var changeButton = UIButton().then {
        
        let yourAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 14),
            .foregroundColor: UIColor.slateGrey,
            .underlineStyle: NSUnderlineStyle.single.rawValue]
        
        let attributeString = NSMutableAttributedString(string: "질문 변경하기",
                                                        attributes: yourAttributes)
        $0.setAttributedTitle(attributeString, for: .normal)
        
    }
    var answerTextView = UITextView().then {
        $0.text = ""
        $0.textColor = .white
        //        $0.isEditable = false
        $0.font = UIFont.systemFont(ofSize: 14)
        $0.textAlignment = .center
        $0.backgroundColor = .darkGrey
        $0.isEditable = false
        
    }
    
    var fixButton = UIButton().then {
        let yourAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 14),
            .foregroundColor: UIColor.slateGrey,
            .underlineStyle: NSUnderlineStyle.single.rawValue]
        
        let attributeString = NSMutableAttributedString(string: "편집",
                                                        attributes: yourAttributes)
        $0.setAttributedTitle(attributeString, for: .normal)
    }
    
    var isPublic = false
    var changePublicDelegate : ChangePublicDelegate?
    var homeAnswerButtonDelegate : HomeAnswerButtonDelegate?
    var homeFixButtonDelegate : HomeFixButtonDelegate?
    let deviceBound = UIScreen.main.bounds.height/812.0
    var homeChangeQuestionDelegate: HomeChangeQuestionDelegate?
    let animationView = AnimationView()
}


//MARK:- LifeCycle Methods
extension NewCardCVC {
    
    
    
    override func awakeFromNib() {
        
        makeItems()
        
        self.backgroundColor = .darkGrey
        self.contentView.backgroundColor = .darkGrey
        self.makeRounded(cornerRadius: 6)
        lockButton.addTarget(self, action: #selector(changePublic), for: .touchUpInside)
        self.setBorder(borderColor: .veryLightPink, borderWidth: 1.0)
        if isInitial{
            initialAnimation()
        }
        
    }
    
    func makeItems(){
        makeLockButton()
        makeQuestionInfoLabel()
        makeDateLabel()
        makeQuestionLabel()
        
        if answerData?.answer == nil || answerData?.answer == ""{
            makeReplyButton()
            makeChangeButton()
            
        }
        else{
            
            makeAnswerTextView()
            makeFixButton()
        }
    }
    
    
}


//MARK:- Setting AutoLayout
extension NewCardCVC {
    
    func makeLockButton(){
        self.addSubview(lockButton)
        lockButton.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(40)
            $0.width.equalTo(36)
            $0.height.equalTo(36)
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
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
        }
    }
    func makeReplyButton(){
        self.addSubview(replyButton)
        replyButton.snp.makeConstraints{
            $0.leading.equalToSuperview().offset(32)
            $0.trailing.equalToSuperview().offset(-32)
            $0.bottom.equalToSuperview().offset(-62)
            $0.height.equalTo(50)
        }
        replyButton.addTarget(self, action: #selector(replyButtonAction), for: .touchUpInside)
    }
    
    func makeChangeButton(){
        self.addSubview(changeButton)
        changeButton.snp.makeConstraints{
            $0.width.equalTo(80)
            $0.bottom.equalToSuperview().offset(-25)
            $0.centerX.equalToSuperview()
        }
        changeButton.addTarget(self, action: #selector(changeButtonAction), for: .touchUpInside)
        
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
    
    func makeFixButton(){
        self.addSubview(fixButton)
        
        fixButton.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-25)
            
        }
        fixButton.addTarget(self, action: #selector(fixButtonAction), for: .touchUpInside)
        
    }
    
    func initialAnimation(){
        if isInitial && !isAnimated{
            isInitial = false
            isAnimated = true
            lockButton.alpha = 0
            dateLabel.alpha = 0
            questionInfoLabel.alpha = 0
            questionLabel.alpha = 0
            replyButton.alpha = 0
            changeButton.alpha = 0
            
            
            //어떤 jsonv파일을 쓸지
            animationView.animation = Animation.named("animation_love_final")
            //화면에 적합하게
            animationView.contentMode = .scaleAspectFit
            //반복되게
            animationView.loopMode = .playOnce
            //실행
            animationView.play()
            //view안에 Subview로 넣어준다,
            self.addSubview(animationView)
            animationView.snp.makeConstraints{
                $0.leading.trailing.bottom.equalToSuperview()
                $0.height.equalTo(219)
            }
            animationView.play(completion: { finished in
                UIView.animate(withDuration: 0.5, animations: {
                    self.lockButton.alpha = 1
                    self.questionInfoLabel.alpha = 1
                    self.dateLabel.alpha = 1
                }, completion: { finished in
                    UIView.animate(withDuration: 0.5, animations: {
                        
                        self.replyButton.alpha = 1
                        self.changeButton.alpha = 1
                        self.animationView.removeFromSuperview()
                    },completion: { f in
                        UIView.animate(withDuration: 0.5, animations: {
                            self.questionLabel.alpha = 1
                        })
                        
                        
                    })
                    
                })
                
                
                
                
            })
            
            
        }
    }
    
    
}



//MARK:- User Define Function

extension NewCardCVC {
    @objc func changePublic(){
        
        changePublicDelegate?.changePublic(idx: index!,answerID: (answerData?.id)!)
        
    }
    @objc func replyButtonAction(){
        homeAnswerButtonDelegate?.answerButtonTapped(index: index!, answerData: answerData!)
    }
    @objc func fixButtonAction(){
        homeFixButtonDelegate?.fixButtonTapped(idx: index!)
    }
    @objc func changeButtonAction(){
        homeChangeQuestionDelegate?.getNewQuestion(idx: index!,answerID: (answerData?.id)!)
    }
    
    
    func setLock(after : Bool){
        if after == true {
            
            lockButton.setImage(
                UIImage(named: "btnUnlock")?.withRenderingMode(.alwaysOriginal), for: .normal)
            
        }
        else{
            
            lockButton.setImage(
                UIImage(named: "btnLock")?.withRenderingMode(.alwaysOriginal), for: .normal)
            
        }
        
    }
    
    func setItems(){
        if answerData?.lock == true{
            lockButton.setImage(
                UIImage(named: "btnLock")?.withRenderingMode(.alwaysOriginal), for: .normal)
        }
        else{
            lockButton.setImage(
                UIImage(named: "btnUnlock")?.withRenderingMode(.alwaysOriginal), for: .normal)
        }
        
        
        questionInfoLabel.text = "[ \((answerData?.questionCategory)!)에 관한 \((answerData?.answerIdx)!)번째 질문 ]"
        
        questionLabel.text = answerData?.question
        dateLabel.text = answerData?.createdTime
        answerTextView.text = answerData?.answer
        
        if answerData?.answer == ""{
            answerTextView.removeFromSuperview()
            fixButton.removeFromSuperview()
            makeReplyButton()
            makeChangeButton()
            
        }
        else{
            replyButton.removeFromSuperview()
            changeButton.removeFromSuperview()
            makeAnswerTextView()
            makeFixButton()
        }
    }
    
    
}
