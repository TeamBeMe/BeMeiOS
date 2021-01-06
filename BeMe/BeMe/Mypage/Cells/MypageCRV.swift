//
//  MypageCRV.swift
//  BeMe
//
//  Created by 박세란 on 2021/01/05.
//

import UIKit

class MypageCRV: UICollectionReusableView {
    //MARK:**- IBOutlet Part**
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var answerCountLabel: UILabel!
    @IBOutlet weak var attendanceCountLabel: UILabel!
    @IBOutlet weak var profileEditButton: UIButton!
    @IBOutlet weak var attendanceCountInfoLabel: UILabel!
    @IBOutlet weak var answerCountInfoLabel: UILabel!
    
    
    //MARK:**- Variable Part**
    static let identifier = "MypageCRV"
    
    //MARK:**- Life Cycle Part**
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setProfileEditButton(view: profileEditButton)
        setInfoLabel()
        setLabel(view: answerCountLabel, text: "4")
        setLabel(view: attendanceCountLabel, text: "4123124")
        setLabel(view: nameLabel, text: "재용아 개소리 좀 그만해")

    }
    
    
    //MARK:**- IBAction Part**
    
    //MARK:**- default Setting Function Part**
    func setProfileEditButton(view: UIButton) {
        view.setBorderWithRadius(borderColor: .veryLightPinkTwo, borderWidth: 1, cornerRadius: 3)
        view.backgroundColor = UIColor.white
    }

    func setInfoLabel(){
        attendanceCountInfoLabel.textColor = .slateGrey
        answerCountInfoLabel.textColor = .slateGrey
    }
    
    func setLabel(view: UILabel, text: String){
        view.text = text
    }
    
    func setImgae(view: UIImageView, text: String){
        view.image = UIImage(contentsOfFile: text)
    }
    
    //MARK:**- Function Part**
}
