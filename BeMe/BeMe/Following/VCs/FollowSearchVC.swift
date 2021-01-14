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
            guard let secondPage = pageInstance?.VCArray[1] as? FollowerSearchVC else {return}
            
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
        mailComposerVC.setSubject("BeMe iOS 문의 메일")
        mailComposerVC.setToRecipients(["BeMe@naver.com"])
        mailComposerVC.setMessageBody("BeMe팀이 빠르게 처리할 수 있게 메일 제목에 간단하게 어떤 문의인지 적어주세요!\n\n1. 문의 유형(문의/신고/버그제보/기타) : \n 2. 회원 아이디 (필요시 기입) : \n 3. 문의 내용 :", isHTML: false)
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


protocol FollowAlertDelegate{
    
    func showAlert(id: Int)
}
