//
//  FollowSearchVC.swift
//  BeMe
//
//  Created by Yunjae Kim on 2020/12/30.
//

import UIKit
import MessageUI

class FollowSearchVC: UIViewController, MFMailComposeViewControllerDelegate {
    
    
    var pageInstance : FollowingSearchPVC?
    
    lazy var popupBackgroundView: UIView = UIView()
    
    @IBOutlet weak var followingButton: UIButton!
    @IBOutlet weak var followerButton: UIButton!
    @IBOutlet weak var underLineView: UIView!
    @IBOutlet weak var backButton: UIButton!
    
    var followers: [FollowingFollows] = []
    var followees: [FollowingFollows] = []
    
    var selectedID: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setItems()
        setNotificationCenter()
        // Do any additional setup after loading the view.
        setPopupBackgroundView()
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "followSearchSegue"{
            pageInstance = segue.destination as? FollowingSearchPVC
            pageInstance?.followees = followees
            pageInstance?.followers = followers
            guard let firstPage =  pageInstance?.VCArray[0] as? FollowingSearchVC else {return}
            guard let secondPage = pageInstance?.VCArray[1] as? FollowerSearchVC else {return}
            firstPage.followSearchProfileDelegate = self
            secondPage.followSearchProfileDelegate = self
            secondPage.followAlertDelegate = self
        }
        
    }
    
    private func setPopupBackgroundView() {
        popupBackgroundView.setPopupBackgroundView(to: view)
    }
    
    private func setNotificationCenter() {
        NotificationCenter.default.addObserver(self, selector: #selector(closePopup), name: .init("closePopupNoti"), object: nil)
    }
    

    @objc func closePopup(_ notification: Notification) {
        popupBackgroundView.animatePopupBackground(false)
        guard let userInfo = notification.userInfo as? [String:Any] else { return }
        guard let action = userInfo["action"] as? String else { return }
        
        if action == "report" {
          // 메일보내기
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.21) {
                let mailComposeViewController = self.configuredMailComposeViewController()
                if MFMailComposeViewController.canSendMail() {
                    self.present(mailComposeViewController, animated: true, completion: nil)
                    print("can send mail")
                } else {
                    self.showSendMailErrorAlert()
                }
            }
            
        } else if action == "followerDelete" {
            FollowerDeleteService.shared.delete(id: selectedID!)  {(networkResult) -> (Void) in
                switch networkResult{
                case .success(let data) :
                   
                    print("팔로워 삭제 성공11")
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
     
    }
    
    
    private func configuredMailComposeViewController() -> MFMailComposeViewController {
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self
        mailComposerVC.setSubject("BeMe 유저 신고 ")
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
    
    
    @IBAction func followingButtonAction(_ sender: Any) {
        
        followingButton.tintColor = .black
        followerButton.tintColor = .lightGray
        pageInstance?.setViewControllers([(pageInstance?.VCArray[0])!], direction: .reverse,
                                         animated: true, completion: nil)
        
        
        UIView.animate(withDuration: 0.3, animations: {
            self.underLineView.transform = .identity
        })
        
        
        
    }
    
    
    @IBAction func followerButtonAction(_ sender: Any) {
        followingButton.tintColor = .lightGray
        followerButton.tintColor = .black
        pageInstance?.setViewControllers([(pageInstance?.VCArray[1])!], direction: .forward,
                                         animated: true, completion: nil)
        
        UIView.animate(withDuration: 0.3, animations: {
            self.underLineView.transform = CGAffineTransform(translationX: 157, y: 0)
            
        })
    }
    
    
    @IBAction func backButtonAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
        
    }
    
    
}


//MARK:- User Define Functions
extension FollowSearchVC {
    
    func setItems(){
        followingButton.tintColor = .black
        followerButton.tintColor = .lightGray
        backButton.tintColor = .black
        
        
        
    }
    
    
}



//extension FollowSearchVC: UITableViewButtonSelectedDelegate {
//
//    func settingButtonDidTapped(to indexPath: IndexPath) {
//        print("callll222")
//        popupBackgroundView.animatePopupBackground(true)
//
//        guard let settingActionSheet = UIStoryboard.init(name: "CustomActionSheet", bundle: .main).instantiateViewController(withIdentifier: CustomActionSheetVC.identifier) as?
//                CustomActionSheetVC else { return }
//
//        settingActionSheet.alertInformations = AlertLabels.article
//        settingActionSheet.modalPresentationStyle = .overCurrentContext
//        self.present(settingActionSheet, animated: true, completion: nil)
//    }
//
//}
extension FollowSearchVC: FollowAlertDelegate {
    
    func showAlert(id: Int) {
        selectedID = id
        popupBackgroundView.animatePopupBackground(true)
        
        guard let settingActionSheet = UIStoryboard.init(name: "CustomActionSheet", bundle: .main).instantiateViewController(withIdentifier: CustomActionSheetTwoVC.identifier) as?
                CustomActionSheetTwoVC else { return }
        
        settingActionSheet.alertInformations = AlertLabels.followerReport
        settingActionSheet.modalPresentationStyle = .overCurrentContext
        settingActionSheet.color = .red
        self.present(settingActionSheet, animated: true, completion: nil)
    }
}

extension FollowSearchVC: FollowSearchProfileDelegate{
    func profileSelectedTap(userID: Int){
        guard let profileVC = UIStoryboard(name: "OthersPage",
                                           bundle: nil).instantiateViewController(
                                            withIdentifier: "OthersPageVC") as? OthersPageVC
        else{
            
            return
        }
        profileVC.userID = userID
        self.navigationController?.pushViewController(profileVC, animated: true)
        
        
    }
}


protocol FollowAlertDelegate{
    
    func showAlert(id: Int)
}


protocol FollowSearchProfileDelegate{
    func profileSelectedTap(userID: Int)
    
}
