//
//  SettingVC.swift
//  BeMe
//
//  Created by 이재용 on 2021/01/14.
//

import UIKit
import MessageUI

class SettingVC: UIViewController, MFMailComposeViewControllerDelegate {

    @IBOutlet weak var settingTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func dissmissButtonTapped(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func logOutButtonTapped(_ sender: UIButton) {
        
        print("First")
        UserDefaults.standard.set("guest", forKey: "token")
        
        guard let loginvc = UIStoryboard(name: "LogIn", bundle: nil).instantiateViewController(identifier: "LogInVC") as? UINavigationController else { return }
        
        print("Second")
        loginvc.modalPresentationStyle = .fullScreen
        self.present(loginvc, animated: true) {
            self.navigationController?.popToRootViewController(animated: true)
        }
    }
    
}

extension SettingVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SettingTVC", for: indexPath) as? SettingTVC else { return UITableViewCell() }
        cell.selectionStyle = .none
        return cell
    }
}

extension SettingVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
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
    }
    
    
    private func configuredMailComposeViewController() -> MFMailComposeViewController {
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self
        mailComposerVC.setSubject("BeMe 문의")
        mailComposerVC.setToRecipients(["teambeme@naver.com"])
        mailComposerVC.setMessageBody("1. 문의 유형 ( 문의, 버그 제보, 탈퇴하기, 기타) : \n2. 회원 닉네임 (필요시 기입) : \n3. 문의 내용 : \n\n문의하신 사항은 BeMe팀이 신속하게 처리하겠습니다. 감사합니다 :)", isHTML: false)
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
    
}
