//
//  MypageMyScrapTVC.swift
//  BeMe
//
//  Created by 박세란 on 2021/01/04.
//

import UIKit

class MypageMyScrapTVC: UITableViewCell {
    
    //MARK:**- IBOutlet Part**
    
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var questionInfoLabel: UILabel!
    @IBOutlet weak var answerDateLabel: UILabel!
    @IBOutlet weak var lockButton: UIButton!
    @IBOutlet weak var scrapButton: UIButton!
    var profileEditDelegate: ProfileEditDelegate?
    var answerID: Int?
    //MARK:**- Variable Part**
    private var isScrapped = false
    private var isLocked = false
    static let identifier = "MypageMyScrapTVC"
    
    //MARK:**- Life Cycle Part**
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        cardView.isUserInteractionEnabled = true
        let profileTabGesture = UITapGestureRecognizer(target: self, action: #selector(touchUpCard))
        cardView.addGestureRecognizer(profileTabGesture)
 
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    //MARK:**- IBAction Part**
    @IBAction func scrappedButtonTapped(_ sender: UIButton) {
//        if isScrapped {
//            isScrapped = false
//            sender.setImage(UIImage.init(named: "btnScrapSelected"), for: .normal)
//            
//        } else {
//            isScrapped = true
//            sender.setImage(UIImage.init(named: "btnScrapUnselected"), for: .normal)
//            
//        }
    }
    
    
    @IBAction func lockButtonTapped(_ sender: UIButton) {
//        if isLocked {
//            isLocked = false
//            sender.setImage(UIImage.init(named: "btnLockBlack"), for: .normal)
//            
//        } else {
//            isLocked = true
//            sender.setImage(UIImage.init(named: "btnUnlockExploreBlack"), for: .normal)
//            
//        }
    }
    
    //MARK:**- default Setting Function Part**
    func setCardView(question: String, questionInfo: String, answerDate: String, isLocked: Bool, isScrapped: Bool){
        
        // text init
        questionLabel.text = question
        questionInfoLabel.text = questionInfo
        answerDateLabel.text = answerDate
        
        // button image init
        if isScrapped {
            scrapButton.setImage(UIImage.init(named: "btnScrapSelected"), for: .normal)
            
        } else {
            scrapButton.setImage(UIImage.init(named: "btnScrapUnselected"), for: .normal)
            
        }
        
        if isLocked {
            lockButton.setImage(UIImage.init(named: "btnLockBlack"), for: .normal)
            
        } else {
            lockButton.setImage(UIImage.init(named: "btnUnlockExploreBlack"), for: .normal)
            
        }

        // color
        questionLabel.textColor = .black
        questionInfoLabel.textColor = .slateGrey
        answerDateLabel.textColor = .rgb3A3A3C
        
        // 하이라이팅
        let attributedString = NSMutableAttributedString(string: questionInfoLabel.text!)
        attributedString.addAttribute(NSAttributedString.Key.foregroundColor,
                                      value: UIColor.rgb1C1C1E,
                                      range: (questionInfoLabel.text! as NSString).range(of: #"[0-9]*번째"#,
                                                                                         options: .regularExpression))
        // cardview init
        cardView.backgroundColor = .white
        cardView.setBorderWithRadius(borderColor: .rgbededed, borderWidth: 1, cornerRadius: 6)
        
    }
    //MARK:**- Function Part**
    @objc func touchUpCard(){
        print("aaaa")
        profileEditDelegate?.cardTapped(answerID: answerID!)
        
    }
}
