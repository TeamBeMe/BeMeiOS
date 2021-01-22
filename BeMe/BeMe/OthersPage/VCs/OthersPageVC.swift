//
//  OthersPageVC.swift
//  BeMe
//
//  Created by 박세란 on 2021/01/09.
//

import UIKit
import MessageUI

class OthersPageVC: UIViewController, MFMailComposeViewControllerDelegate { 
    
    //MARK:**- IBOutlet Part**
    @IBOutlet weak var othersPageCollectionView: UICollectionView!
    @IBOutlet weak var reportButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var followButton: UIButton!
    
    lazy var popupBackgroundView: UIView = UIView()
    
    //MARK:**- Variable Part**
    let othersPageCVLayout = OthersPageCVFlowLayout()
    
    let othersPageCVC = OthersPageCVC()
    
    var tableviewHeight: CGFloat = 735.0
    
    var userID: Int?
    
    var isMyProfile: Bool?
    
    private var othersAnswerArray: [Answer] = [] {
        didSet {
            othersPageCollectionView.reloadData()
        }
    }
    
    private var othersProfile: [OthersProfile] = [] {
        didSet {
            othersPageCollectionView.reloadData()
        }
    }
    
    
    
    //MARK:**- Constraint Part**
    
    //MARK:**- Life Cycle Part**
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.navigationController?.interactivePopGestureRecognizer?.delegate = nil
        //        othersAnswerArray = []
        //        othersProfile = []
        othersPageCollectionView.delegate = self
        othersPageCollectionView.dataSource = self
        
        if #available(iOS 11.0, *) {
            othersPageCollectionView.automaticallyAdjustsScrollIndicatorInsets = false
        } else {
            automaticallyAdjustsScrollViewInsets = false
        }
        self.navigationController?.interactivePopGestureRecognizer?.delegate = nil
        othersPageCollectionView.collectionViewLayout = othersPageCVLayout
        setNotificationCenter()
        othersPageCollectionView.collectionViewLayout
            = othersPageCVLayout
        
        setPopupBackgroundView()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.isHidden = true
        getAnswerData(userId: userID!, page: 1)
        getProfileData(userId: userID!)

    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    //MARK:**- IBAction Part**
    
    @IBAction func backButtonAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func reportButtonTapped(_ sender: Any) {
        popupBackgroundView.animatePopupBackground(true)
        guard let settingActionSheet = UIStoryboard.init(name: "CustomActionSheet", bundle: .main).instantiateViewController(withIdentifier: CustomActionSheetOneVC.identifier) as?
                CustomActionSheetOneVC else { return }
        
        settingActionSheet.modalPresentationStyle = .overCurrentContext
        self.present(settingActionSheet, animated: true, completion: nil)
    }
    
    //MARK:**- default Setting Function Part**
    
    func setKeywordLabel( label : UILabel, keyword: String){
        label.text = keyword
        label.textColor = UIColor.darkGray
        
    }
    
    
    //MARK:**- Function Part**
    
    private func setNotificationCenter() {
        NotificationCenter.default.addObserver(self, selector: #selector(closePopup), name: .init("closePopupNoti"), object: nil)
    }
    
    @objc func closePopup(_ notification: Notification) {
        popupBackgroundView.animatePopupBackground(false)
        guard let userInfo = notification.userInfo as? [String:Any] else { return }
        guard let action = userInfo["action"] as? String else { return }
        
        if action == "commentPut" {
            
        } else if action == "report" {
            // 메일 띄우기
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.21) {
                let mailComposeViewController = self.configuredMailComposeViewController()
                if MFMailComposeViewController.canSendMail() {
                    self.present(mailComposeViewController, animated: true, completion: nil)
                    print("can send mail")
                } else {
                    self.showSendMailErrorAlert()
                }
            }
            
        } else if action == "commentDelete" {
            
        } else if action == "block" {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.21) {
                
                let alertViewController = UIAlertController(title: "업데이트 될 예정입니다.", message: "다음 업데이트를 기다려주세요🥰", preferredStyle: .alert)
                let action = UIAlertAction(title: "확인", style: .cancel, handler: nil)
                alertViewController.addAction(action)
                self.present(alertViewController, animated: true, completion: nil)
            }
            
        }
        
        print(action)
    }
 
    
    private func configuredMailComposeViewController() -> MFMailComposeViewController {
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self
        mailComposerVC.setSubject("BeMe 유저 신고")
        mailComposerVC.setToRecipients(["teambeme@naver.com"])
        mailComposerVC.setMessageBody("1. 신고 유형  사유 (상업적 광고 및 판매, 음란물/불건전한 대화, 욕설 및 비하, 도배, 부적절한 프로필 이미지, 기타 사유) : \n 2. 신고할 유저의 닉네임 : \n\n 신고하신 사항은 BeMe팀이 신속하게 처리하겠습니다. 감사합니다 :)", isHTML: false)
        return mailComposerVC
    }
    
    private func showSendMailErrorAlert() {
        
        let sendMailErrorAlert = UIAlertController(title: "메일을 전송 실패", message: "아이폰 이메일 설정을 확인하고 다시 시도해주세요.", preferredStyle: .alert)
        
        let cancelButton = UIAlertAction(title: "확인", style: .cancel, handler: nil)
        
        sendMailErrorAlert.addAction(cancelButton)
        self.present(sendMailErrorAlert, animated: true, completion: nil)
    }
    
    internal func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    
    
    private func setPopupBackgroundView() {
        popupBackgroundView.setPopupBackgroundView(to: view)
    }

    
    
    
}
//MARK:**- extension 부분**
extension OthersPageVC : UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
    }
    
}

extension OthersPageVC : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: OthersPageCVC.identifier,
                for: indexPath) as? OthersPageCVC else {
            return UICollectionViewCell()}
        
        
        
        
        cell.othersAnswerArray = othersAnswerArray
        print("otehrspage CV ")
        cell.otherspageTableView.reloadData()
        
        
        return cell
    }
    
    
    
}

extension OthersPageVC : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        
        tableviewHeight = CGFloat(othersAnswerArray.count) * 105.0
        tableviewHeight = (tableviewHeight < 588.0) ? 588 : tableviewHeight
        return CGSize(width: collectionView.frame.width  , height: tableviewHeight)
    }
    
    
    // header size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if (section == 0) {
            return CGSize(width: collectionView.frame.width, height: 294)
        } else {
            //refact
            return CGSize.zero
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    //    UIEdgeInset
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
        
    }
    
    // collectionview heaeder 사용
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView{
        
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: OthersPageCRV.identifier, for: indexPath) as? OthersPageCRV else {
                assert(false, "응 아니야")
                return UICollectionReusableView()
            }
            
            print("IsMyProfile: \(isMyProfile)")
//            headerView.isMyProfile = isMyProfile
            headerView.othersProfile = othersProfile
            
            
            if (othersProfile.count != 0) {
                print("headerView.othersProfile = othersProfileheaderView.othersProfile = othersProfile")
                print(othersProfile[0].profileImg!)
                headerView.setProfile(nickname: othersProfile[0].nickname, img: othersProfile[0].profileImg!, visit: String(othersProfile[0].continuedVisit), answerCount: String(othersProfile[0].answerCount), isFollowed: othersProfile[0].isFollowed!)
                //                print("othersProfile[0].isFollowed")
                //                print(othersProfile[0].isFollowed)
            }
            
            return headerView
        default:
            assert(false, "응 아니야")
            
        }
        
        return UICollectionReusableView()
        
    }
}


extension OthersPageVC {
    private func getAnswerData(userId: Int, page: Int) {
        OthersPageAnswerService.shared.getOthersAnswer(userId: userId, page: page) { (result) in
            switch result {
            case .success(let data):
                if let response = data as? OthersAnswer{
                    print("setAnswerData 성공")
                    
                    
                    self.othersAnswerArray = response.answers
                    //                    print("setAnswerData 안에ㅐ서")
                    //                    print(response)
                    if self.othersAnswerArray.count != 0{
                        if self.othersAnswerArray[0].userID == self.userID {
                            self.isMyProfile = true
                        } else {
                            self.isMyProfile = false
                        }
                    }
                 
                    self.othersPageCollectionView.reloadData()
                }
            case .requestErr(let msg):
                if let message = msg as? String {
                    print(message)
                    print("setAnswerData 실패")
                }
            case .pathErr :
                print("pathErr")
            case .serverErr :
                print("serverERr")
            case .networkFail :
                print("networkFail")
            default :
                print("?")
            }
        }
        
        
    }
    
    
    private func getProfileData(userId: Int) {
        OthersPageProfileService.shared.getOthersProfile(userId: userId) { (result) in
            switch result {
            case .success(let data):
                if let othersProfile = data as? OthersProfile{
                    print("setProfileData 성공")
                    
                    self.othersProfile.append(othersProfile)
                    
                    
                }
            case .requestErr(let msg):
                if let message = msg as? String {
                    print(message)
                    print("setProfileData 실패")
                }
            case .pathErr :
                print("pathErr")
            case .serverErr :
                print("serverERr")
            case .networkFail :
                print("networkFail")
            default :
                print("?")
            }
        }
        
    }
}

extension OthersPageVC: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset.y
        if offset < 91.0 {
            backButton.isHidden = false
            reportButton.isHidden = false
        } else {
            backButton.isHidden = true
            reportButton.isHidden = true
        }
    }
}
