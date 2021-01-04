//
//  MypageOthersScrapTVC.swift
//  BeMe
//
//  Created by 박세란 on 2021/01/04.
//

import UIKit

class MypageOthersScrapTVC: UITableViewCell {
    
    //MARK:**- IBOutlet Part**
    
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var questionInfoLabel: UILabel!
    @IBOutlet weak var answerDateLabel: UILabel!
    @IBOutlet weak var writerLabel: UILabel!
    @IBOutlet weak var writerImageView: UIImageView!
    @IBOutlet weak var scrapButton: UIButton!
    
    //MARK:**- Variable Part**
    private var isScrapped = false
    
    //MARK:**- Life Cycle Part**
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setCardView(question: "dbnd`", questionInfo: "아요 1번째 경험", answerDate: "202020202", writer: "btnScrapSelected", writerImg: "btnScrapSelected", isScrapped: true)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    //MARK:**- IBAction Part**
    @IBAction func scrappedButtonTapped(_ sender: UIButton) {
        if isScrapped {
            isScrapped = false
            sender.setImage(UIImage.init(named: "btnScrapSelected"), for: .normal)
            
        } else {
            isScrapped = true
            sender.setImage(UIImage.init(named: "btnScrapUnselected"), for: .normal)
            
        }
    }
    
    
    
    //MARK:**- default Setting Function Part**
    func setCardView(question: String, questionInfo: String, answerDate: String, writer: String, writerImg: String, isScrapped: Bool){
        
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
        writerImageView.image = UIImage(named: writerImg)
        
        
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
    
}
