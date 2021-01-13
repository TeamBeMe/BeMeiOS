//
//  MypageCRV.swift
//  BeMe
//
//  Created by 박세란 on 2021/01/05.
//

import UIKit

class MypageCRV: UICollectionReusableView {
    //MARK:**- IBOutlet Part**
    
    // image
    @IBOutlet weak var settingButton: UIButton!
    @IBOutlet weak var profileImage: UIImageView!
    // profile
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var answerCountLabel: UILabel!
    @IBOutlet weak var attendanceCountLabel: UILabel!
    @IBOutlet weak var profileEditButton: UIButton!
    @IBOutlet weak var attendanceCountInfoLabel: UILabel!
    @IBOutlet weak var answerCountInfoLabel: UILabel!
    // header
    @IBOutlet weak var myAnswerButton: UIButton!
    @IBOutlet weak var scrappedAnswerButton: UIButton!
    @IBOutlet weak var highLightBar: UIView!
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var searchTextField: UITextField!
    
    // height
    @IBOutlet weak var profileImageHeight: NSLayoutConstraint!
    @IBOutlet weak var profileViewHeight: NSLayoutConstraint!
    
    
    //MARK:**- Variable Part**
    static let identifier = "MypageCRV"
    
    let mypageCVC = MypageCVC()
    
    var delegate: MypageCVCDelegate?
    
    
    var myProfile: [MyProfile] = [] 
    
    //MARK:**- Life Cycle Part**
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setProfileEditButton(view: profileEditButton)
        setInfoLabel()
        setLabel(view: answerCountLabel, text: "4")
        setLabel(view: attendanceCountLabel, text: "4123124")
        setLabel(view: nameLabel, text: "재용아 개소리 좀 그만해")
        setSearhButton(view: searchView)
        
    }
    
    
    //MARK:**- IBAction Part**
    
    @IBAction func filterButtonTapped(_ sender: UIButton) {
    }
    
    @IBAction func deleteButtonTapped(_ sender: UIButton) {
        setKeywordLabel(label: searchTextField, keyword: "")
    }
    
    @IBAction func myAswerButtonTapped(_ sender: UIButton) {
        myAnswerButton.setTitleColor(.black, for: .normal)
        scrappedAnswerButton.setTitleColor(.rgb8E8E93, for: .normal)
        delegate?.myAnswerItem()
        moveHighLightBar(to: sender)
    }
    @IBAction func scrappedAswerButtonTapped(_ sender: UIButton) {
        myAnswerButton.setTitleColor(.rgb8E8E93, for: .normal)
        scrappedAnswerButton.setTitleColor(.black, for: .normal)
        delegate?.othersAnswerItem()
        moveHighLightBar(to: sender)
    }
    
    //MARK:**- default Setting Function Part**
    
    func setProfile(nickname: String, img: String, visit: String, answerCount: String){
        setProfileEditButton(view: profileEditButton)
        setInfoLabel()
        nameLabel.text = nickname
        profileImage.imageFromUrl(img, defaultImgPath: "imgMypage")
        attendanceCountLabel.text = visit
        answerCountLabel.text = answerCount
        setSearhButton(view: searchView)
    }
    
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
    
    
    // 아래 두 함수는 TVC 뿐만 아니라 여러 곳에서 사용가능
    // 검색어를 삭제했거나 , 초기 화면
    func setKeywordLabel(label : UITextField){
        label.text = "검색"
        label.textColor = UIColor.rgb8E8E93
    }
    
    // 검색 결과 후
    func setKeywordLabel( label : UITextField, keyword: String){
        label.text = keyword
        label.textColor = UIColor.darkGray
        
    }
    
    //MARK:**- Function Part**
    private func moveHighLightBar(to button: UIButton) {
        
        UIView.animate(withDuration: 0.2, delay: 0, options: [.curveLinear], animations: {
            // Slide Animation
            self.highLightBar.frame.origin.x = 30 + button.frame.minX
            
        }) { _ in
            
        }
    }
}
