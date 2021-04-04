//
//  OthersPageTVC.swift
//  BeMe
//
//  Created by 박세란 on 2021/01/09.
//

import UIKit

class OthersPageTVC: UITableViewCell {
    
    //MARK:**- IBOutlet Part**
    
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var questionInfoLabel: UILabel!
    @IBOutlet weak var answerDateLabel: UILabel!
    @IBOutlet weak var writerLabel: UILabel!
    @IBOutlet weak var writerImageView: UIImageView!
    @IBOutlet weak var scrapButton: UIButton!
    var profileEditDelegate: ProfileEditDelegate?
    //MARK:**- Variable Part**
    private var isScrapped = true
    static let identifier = "OthersPageTVC"
    var answerId: Int?
    var otherAnswer: Answer?
    var questionId: Int?
    
    weak var delegate: UITableViewButtonSelectedDelegate?
    
    //MARK:**- Life Cycle Part**
    
    override func awakeFromNib() {
        super.awakeFromNib()
        cardView.isUserInteractionEnabled = true
        let profileTabGesture = UITapGestureRecognizer(target: self, action: #selector(touchUpCard))
        cardView.addGestureRecognizer(profileTabGesture)
        // Initialization code
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    //MARK:**- IBAction Part**
    @IBAction func scrappedButtonTapped(_ sender: UIButton) {
        
        
//        if otherAnswer!.isAnswered == false {
//            NotificationCenter.default.post(name: .scrapToast, object: nil)
//            return
//        }
        
        if isScrapped {
            isScrapped = false
            sender.setImage(UIImage.init(named: "btnScrapSelected"), for: .normal)
            
        } else {
            isScrapped = true
            sender.setImage(UIImage.init(named: "btnScrapUnselected"), for: .normal)
            
        }
        delegate?.exploreAnswerScrapButtonDidTapped(answerId!)
        print("answerid 는 무엇이냐면 ! ")
        print(answerId!)
    
    }
    
    
    
    //MARK:**- default Setting Function Part**
    func setCardView(question: String, questionInfo: String, answerDate: String, writer: String, writerImg: String, isScrapped: Bool, answerId: Int, questionId: Int){
        
        // id init
        self.answerId = answerId
        self.questionId = questionId
        
        // text init
        questionLabel.text = question
        questionInfoLabel.text = questionInfo
        answerDateLabel.text = answerDate
        writerLabel.text = writer
        
        // button image init
        if isScrapped {
            scrapButton.setImage(UIImage.init(named: "btnScrapSelected"), for: .normal)
            
        } else {
            scrapButton.setImage(UIImage.init(named: "btnScrapUnselected"), for: .normal)
            
        }
        
        // writer profile image init
        writerImageView.imageFromUrl(writerImg, defaultImgPath: "img")
        writerImageView.makeRounded(cornerRadius: 10)
        writerImageView.contentMode = .scaleAspectFill
   
        
        // color
        questionLabel.textColor = .black
        questionInfoLabel.textColor = .slateGrey
        answerDateLabel.textColor = .rgb3A3A3C
        
        // 하이라이팅
        let attributedString = NSMutableAttributedString(string: questionInfoLabel.text!)
        attributedString.addAttribute(NSAttributedString.Key.foregroundColor,
                                      value: UIColor.rgb1C1C1E,
                                      range: (questionInfoLabel.text! as NSString).range(of: #"[0-9]*번째"#, options: .regularExpression))
        // cardview init
        cardView.backgroundColor = .white
        cardView.setBorderWithRadius(borderColor: .rgbededed, borderWidth: 1, cornerRadius: 6)
        
        
    }
    //MARK:**- Function Part**
    @objc func touchUpCard(){
//        if otherAnswer!.isAnswered == false {
//            NotificationCenter.default.post(name: .scrapToast, object: nil)
//            return
//        }
        
        profileEditDelegate?.cardTapped(answerID: answerId!)
        
        
        
        
    }
}
