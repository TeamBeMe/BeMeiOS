//
//  FollowSearchVC.swift
//  BeMe
//
//  Created by Yunjae Kim on 2020/12/30.
//

import UIKit

class FollowSearchVC: UIViewController {
    
    
    var pageInstance : FollowingSearchPVC?
    
    @IBOutlet weak var followingButton: UIButton!
    @IBOutlet weak var followerButton: UIButton!
    @IBOutlet weak var underLineView: UIView!
    @IBOutlet weak var backButton: UIButton!
    lazy var popupBackgroundView: UIView = UIView()
    var followers: [FollowingFollows] = []
    var followees: [FollowingFollows] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setItems()
        // Do any additional setup after loading the view.
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
    
    

    @objc func closePopup(_ notification: Notification) {
        popupBackgroundView.removeFromSuperview()
        guard let userInfo = notification.userInfo as? [String:Any] else { return }
        guard let action = userInfo["action"] as? String else { return }
        
        if action == "commentPut" {
            
    
            
        } else if action == "report" {
            // 메일 띄우기
        } else if action == "commentDelete" {
            
            
        } else if action == "block" {
          
            
        }
        
     
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
    
    func showAlert() {
        popupBackgroundView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.4)
        view.addSubview(popupBackgroundView)
        popupBackgroundView.snp.makeConstraints{
            $0.top.bottom.leading.trailing.equalToSuperview()
        }
        
        guard let settingActionSheet = UIStoryboard.init(name: "CustomActionSheet", bundle: .main).instantiateViewController(withIdentifier: CustomActionSheetTwoVC.identifier) as?
                CustomActionSheetTwoVC else { return }
        
        settingActionSheet.alertInformations = AlertLabels.followerReport
        settingActionSheet.modalPresentationStyle = .overCurrentContext
        settingActionSheet.color = .red
        self.present(settingActionSheet, animated: true, completion: nil)
    }
}


protocol FollowAlertDelegate{
    
    func showAlert()
}
