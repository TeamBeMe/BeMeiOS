//
//  AnswerVC.swift
//  BeMe
//
//  Created by 박세란 on 2020/12/28.
//

import UIKit

class AnswerVC: UIViewController {
    
    //MARK:**- IBOutlet Part**
    
    /// Label, ColelctionView, TextField, ImageView 등 @IBOutlet 변수들을 선언합니다.  // 변수명 lowerCamelCase 사용
    
    /// ex)  @IBOutlet weak var qnaTextBoxBackgroundImage: UIImageView!
    
    @IBOutlet weak var questionLabel: UILabel!
    
    @IBOutlet weak var questionInfoLabel: UILabel!
    
    @IBOutlet weak var answerDateLabel: UILabel!
    
    @IBOutlet weak var answerTextView: UITextView!
    
    @IBOutlet weak var finishButton: UIButton!
    
    @IBOutlet weak var backButton: UIButton!
    
    @IBOutlet weak var answerSwitch: UISwitch!
    
    @IBOutlet weak var commentSwitch: UISwitch!
    
    @IBOutlet weak var textViewBottomConstraint: NSLayoutConstraint!
    //MARK:**- Variable Part**
    
    /// 뷰컨에 필요한 변수들을 선언합니다  // 변수명 lowerCamelCase 사용
    
    /// ex)  var imageViewList : [UIImageView] = []
    
    //
    var answerData: AnswerDataForViewController?
    var followScrapButtonDelegate: FollowScrapButtonDelegate?
    // AnswerVC 에서 init
    var answer: String?
    var isAnswerPublic: Bool = true
    var isCommentPublic: Bool = true
    
    var isInitial: Bool = true
    var inputText: String = ""
    var initialText: String = ""
    var answerDataDelegate: HomeGetDataFromAnswerDelegate?
    var curCardIdx : Int?
    var isRegister: Bool?
    var isFromFollowingTab = false
    var indexInFollowingVC: Int?
    //MARK:**- Constraint Part**
    
    /// 스토리보드에 있는 layout 에 대한 @IBOutlet 을 선언합니다. (Height, Leading, Trailing 등등..)  // 변수명 lowerCamelCase 사용
    
    /// ex) @IBOutlet weak var lastImageBottomConstraint: NSLayoutConstraint!
    
    //MARK:**- Life Cycle Part**
    
    /// 앱의 Life Cycle 부분을 선언합니다
    
    /// ex) override func viewWillAppear() { }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        setLabels()
        //        answerTextView.text = ""
        //        answerTextView.becomeFirstResponder()
        registerForKeyboardNotifications()
        FollowingVC.fromWhichView = 1
        self.navigationController?.interactivePopGestureRecognizer?.delegate = nil
        NotificationCenter.default.addObserver(self, selector: #selector(shouldPop), name: .answerPop, object: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        answerTextView.delegate = self
        setTextView(answerTextView)
        setLabels()
        clarifyRegister()
        commentSwitch.isOn = !isCommentPublic
        
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        unregisterForKeyboardNotifications()
        
    }
    
    //MARK:**- IBAction Part**
    
    /// 버튼과 같은 동작을 선언하는 @IBAction 을 선언합니다 , IBAction 함수 명은 동사 형태로!!  // 함수명 lowerCamelCase 사용
    
    /// ex) @IBOutlet @IBAction func answerSelectedButtonClicked(_ sender: Any) { }
    @IBAction func answerSwitchValueCanged(_ sender: Any) {
        
        if self.answerSwitch.isOn {
            isAnswerPublic = true
            
        } else {
            isAnswerPublic = false
        }
        answerData!.lock = !answerData!.lock!
        print(isAnswerPublic)
        
    }
    
    
    @IBAction func commentSwitchValueCanged(_ sender: Any) {
        if self.commentSwitch.isOn {
            isCommentPublic = false
        } else {
            isCommentPublic = true
        }
        print(isCommentPublic)
        
    }
    
    
    //MARK:**- default Setting Function Part**
    
    /// 기본적인 세팅을 위한 함수 부분입니다 // 함수명 lowerCamelCase 사용
    
    /// ex) func tableViewSetting() {
    
    ///         myTableView.delegate = self
    
    ///         myTableView.datasource = self
    
    ///    }
    
    // 다른 화면을 터치하면 키보드가 내려옴
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        answerTextView.resignFirstResponder()
        
    }
    
    
    
    // placeholder 및 커서 작업
    func setTextView(_ textView: UITextView){
        
        let savedAnswer = UserDefaults.standard.string(forKey: "answer")
        
        if savedAnswer == "" || savedAnswer == nil {
            textView.text = "답변을 입력해주세요."
            textView.textColor = .lightGray
            
            let position = textView.beginningOfDocument
            textView.selectedTextRange = textView.textRange(from:position, to:position)
//            textView.beginFloatingCursor(at: CGPoint(x: 0, y: 0))
            
        } else {
            textView.text = savedAnswer
            textView.textColor = .black
            //
            let position = textView.endOfDocument
            textView.selectedTextRange = textView.textRange(from:position, to:position)
//            textView.endFloatingCursor()
            //
            isInitial = false
        }
    }
    
    // 질문 관련 데이터 init
    func setLabels(){
        
        questionLabel.text = answerData?.question
        //        questionInfoLabel.text = "[ \((answerData?.questionCategory)!)에 관한 \((answerData?.answerIdx)!)번째 질문 ]"
        answerDateLabel.text = answerData?.createdTime
        if answerData?.commentPublicFlag == 0 {
            commentSwitch.isOn = true
        }
        else {
            commentSwitch.isOn = false
        }
        
        answerDateLabel.textColor = .slateGrey
        questionInfoLabel.textColor = .slateGrey
        let mainString = "[ \((answerData?.questionCategory)!)에 관한 \((answerData?.answerIdx)!)번째 질문 ]"
        
        let range = (mainString as! NSString).range(of: String((answerData?.answerIdx)!)+"번째")
        let mutableAttributedString = NSMutableAttributedString.init(string: mainString)
        mutableAttributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.black, range: range)
        
        questionInfoLabel.attributedText = mutableAttributedString
        
        finishButton.setTitleColor(.veryLightPink, for: .normal)
        answerTextView.text = answerData?.answer
        textViewDidChange(answerTextView)
//        answerTextView.becomeFirstResponder()
        
        
        answerSwitch.isOn = !answerData!.lock!
        
        
        
    }
    func clarifyRegister(){
        if answerData?.answer == "" || answerData?.answer == ""{
            isRegister = true
        }
        else{
            isRegister = false
        }

    }
    
    
    //MARK:**- Function Part**
    
    /// 로직을 구현 하는 함수 부분입니다. // 함수명 lowerCamelCase 사용
    
    /// ex) func tableViewSetting() {
    
    ///         myTableView.delegate = self
    
    ///         myTableView.datasource = self
    
    ///    }
    @objc func shouldPop(_notification: Notification){
        self.navigationController?.popViewController(animated: true)
        
        
    }
    
    @IBAction func backButtonAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func finishButtonAction(_ sender: Any) {
        answerData!.answer = answerTextView.text
        if isRegister! == true{
            print("글쓰기 시도")
            AnswerRegistService.shared.regist(answerID: answerData!.id!, content: answerData!.answer!, commentBlocked: commentSwitch.isOn, isPublic: answerSwitch.isOn) {(networkResult) -> (Void) in
                switch networkResult{
                case .success(let data) :
                    print(self.isFromFollowingTab)
                    if self.isFromFollowingTab {
                        self.followScrapButtonDelegate?.fromAnswerVC(indexInVC: self.indexInFollowingVC!)
                    }
                case .requestErr(let msg):
                    if let message = msg as? String {
                        print(message)
                    }
                case .pathErr :
                    print("pathErr")
                case .serverErr :
                    print("serverErr")
                case .networkFail:
                    print("networkFail")
                    
                }
            }

        }
        else{
            AnswerModifyService.shared.modify(answerID: answerData!.id!, content: answerData!.answer!, commentBlocked: commentSwitch.isOn, isPublic: answerSwitch.isOn) {(networkResult) -> (Void) in
                switch networkResult{
                case .success(let data) :
                    print("success")
                case .requestErr(let msg):
                    if let message = msg as? String {
                        print(message)
                    }
                case .pathErr :
                    print("pathErr")
                case .serverErr :
                    print("serverErr")
                case .networkFail:
                    print("networkFail")
                    
                }
            }
            
            
            
        }
        
        
       
        
      
        
        
        answerDataDelegate?.setNewAnswer(answerData: answerData!)
        
    }
    
    func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow(_:)), name:
                                                UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name:
                                                UIResponder.keyboardWillHideNotification, object: nil)
    }
    @objc func keyboardWillShow(_ notification: NSNotification) {
        
        
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey]
                                as? NSValue)?.cgRectValue {
            
            textViewBottomConstraint.constant = 30 + keyboardSize.height - (view.frame.height-answerTextView.frame.maxY)
            
            
        }
    }
    
    @objc func keyboardWillHide(_ notification: NSNotification) {
        //        guard let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey]
        //            as? Double else {return}
        //        guard let curve = notification.userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey]
        //            as? UInt else {return}
        textViewBottomConstraint.constant = 30
        
    }
    func unregisterForKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name:
                                                    UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name:
                                                    UIResponder.keyboardWillHideNotification, object: nil)
    }
    
}

//MARK:**- extension 부분**

/// UICollectionViewDelegate 부분 처럼 외부 프로토콜을 채택하는 경우나, 외부 클래스 확장 할 때,  extension을 작성하는 부분입니다

/// ex) extension ViewController : UICollectionViewDelegate { }

extension AnswerVC: UITextViewDelegate {
    
    
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        if isInitial {
            textView.text = ""
            initialText = text
            textView.textColor = .black
        }
        
        answer = textView.text
        
        return true
    }
    
    func textViewDidChange(_ textView: UITextView) {
        
        if isInitial {
            textView.text = initialText
            textView.textColor = .black
        }
        if textView.text != "" {
            finishButton.setTitleColor(.black, for: .normal)
        }
        else{
            finishButton.setTitleColor(.veryLightPink, for: .normal)
        }
        
        inputText = textView.text
        UserDefaults.standard.set(textView.text, forKey: "answer")
        self.isInitial = false
        
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if self.isInitial {
            setTextView(textView)
        }
        
        // 값이 비어있으면, 다시 placeholder 설정 
        if textView.text == "" {
            setTextView(textView)
            isInitial = true
        }
    }
    
    
}

