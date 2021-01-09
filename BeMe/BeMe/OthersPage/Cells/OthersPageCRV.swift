//
//  OthersPageCRV.swift
//  BeMe
//
//  Created by 박세란 on 2021/01/09.
//

import UIKit

class OthersPageCRV: UICollectionReusableView {
    //MARK:**- IBOutlet Part**
    // image
    @IBOutlet weak var reportButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var followButton: UIButton!
    // profile
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var answerCountLabel: UILabel!
    @IBOutlet weak var attendanceCountLabel: UILabel!
    @IBOutlet weak var attendanceCountInfoLabel: UILabel!
    @IBOutlet weak var answerCountInfoLabel: UILabel!
    // height
    @IBOutlet weak var profileImageHeight: NSLayoutConstraint!
    @IBOutlet weak var profileViewHeight: NSLayoutConstraint!
    
    //MARK:**- Variable Part**
    static let identifier = "OthersPageCRV"
    
    //MARK:**- Life Cycle Part**
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setProfileEditButton(view: followButton)
        setInfoLabel()
        setLabel(view: answerCountLabel, text: "4")
        setLabel(view: attendanceCountLabel, text: "4123124")
        setLabel(view: nameLabel, text: "재용아 개소리 좀 그만해")
    }
    
    
    //MARK:**- IBAction Part**
    @IBAction func backButtonTapped(_ sender: Any) {
    }
    @IBAction func reportButtonTapped(_ sender: Any) {
    }
    @IBAction func followButtonTapped(_ sender: Any) {
    }
    
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
    
    func setSearhButton(view: UIView) {
        view.setBorderWithRadius(borderColor: .veryLightPinkTwo, borderWidth: 1, cornerRadius: 6)
        view.backgroundColor = UIColor.veryLightPinkTwo
    }
    
    //MARK:**- Function Part**
        
}
