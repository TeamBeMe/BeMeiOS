//
//  MypageCRV.swift
//  BeMe
//
//  Created by 박세란 on 2021/01/05.
//

import UIKit

protocol CategorySelectedProtocol {
    func categoryButtonDidTapped()
}

extension CategorySelectedProtocol {
    func categoryButtonDidTapped() {}
}
class MypageCRV: UICollectionReusableView {
    //MARK:**- IBOutlet Part**
    
    // image
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
    
    var categoryDelegte: CategorySelectedProtocol?
    
    var profileEditDelegate: ProfileEditDelegate?
    
    var MypageCRVDelegate: MypageCRVDelegate?

    var myProfile: [MyProfile] = [] 
    
    //MARK:**- Life Cycle Part**
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setProfileEditButton(view: profileEditButton)
        setInfoLabel()
        setSearhButton(view: searchView)
        searchTextField.delegate = self
        
    }
    
    
    //MARK:**- IBAction Part**
    
    @IBAction func filterButtonTapped(_ sender: UIButton) {
        categoryDelegte?.categoryButtonDidTapped()
    }
    
    @IBAction func deleteButtonTapped(_ sender: UIButton) {
        setKeywordLabel(label: searchTextField, keyword: "")
        NotificationCenter.default.post(name: .init("keyword"), object: nil, userInfo: ["keyword": ""])
        MypageCRVDelegate?.deleteButtonSearch()
    }
    
    @IBAction func myAswerButtonTapped(_ sender: UIButton) {
        myAnswerButton.setTitleColor(.black, for: .normal)
        scrappedAnswerButton.setTitleColor(.rgb8E8E93, for: .normal)
        delegate?.myAnswerItem()
        print("myAswerButtonTapped")
        moveHighLightBar(to: sender)
    }
    @IBAction func scrappedAswerButtonTapped(_ sender: UIButton) {
        myAnswerButton.setTitleColor(.rgb8E8E93, for: .normal)
        scrappedAnswerButton.setTitleColor(.black, for: .normal)
        delegate?.myScrapItem()
        print("scrappedAswerButtonTapped")
        moveHighLightBar(to: sender)
    }
    @IBAction func searchButtonTapped(_ sender: UIButton) {
        NotificationCenter.default.post(name: .init("keyword"), object: nil, userInfo: ["keyword": searchTextField.text! ])
        MypageCRVDelegate?.searchButtonSearch()
    }
    
    @IBAction func profileEditButtonTapped(_ sender: Any) {
        profileEditDelegate?.profileEdit()
        
    }
    
    
    //MARK:**- default Setting Function Part**
    
    func setProfile(nickname: String, img: String, visit: String, answerCount: String){
        setProfileEditButton(view: profileEditButton)
        setInfoLabel()
        nameLabel.text = nickname
        profileImage.imageFromUrl(img, defaultImgPath: "mypageDefault")
        attendanceCountLabel.text = visit
        answerCountLabel.text = answerCount
        setSearhButton(view: searchView)
    }
    
    func setProfileImage(img: UIImage){
        profileImage.image = img

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
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.endEditing(true)
    }
}

extension MypageCRV: UITextFieldDelegate {

    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("HEELvdsvsdv")
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        print("TextFieldDId")
        print(textField.text!)
        
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        NotificationCenter.default.post(name: .init("keyword"), object: nil, userInfo: ["keyword": textField.text!])
        
        self.endEditing(true)
        
        MypageCRVDelegate?.searchButtonSearch()
        return true
    }
}

protocol MypageCRVDelegate {
    func searchButtonSearch()
    func deleteButtonSearch()
}

