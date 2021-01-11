//
//  CustomActionSheetTwoVC.swift
//  BeMe
//
//  Created by 이재용 on 2021/01/07.
//

import UIKit

class CustomActionSheetTwoVC: UIViewController {
    static let identifier: String = "CustomActionSheetTwoVC"
    
    @IBOutlet weak var wrapper: UIView!
    @IBOutlet weak var firstItemImageView: UIImageView!
    @IBOutlet weak var firstItemLabel: UILabel!
    @IBOutlet weak var secondItemImageView: UIImageView!
    @IBOutlet weak var secondItemLabel: UILabel!
    @IBOutlet weak var cancelButton: UIButton!
    
    var alertInformations: AlertLabels?
    
    var color: UIColor?
    
    var isOnlySecondTextColored: Bool = false
    
    var secondColor: UIColor?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        wrapper.roundCorners(cornerRadius: 10.0, maskedCorners: [.layerMaxXMinYCorner, .layerMinXMinYCorner])
        
        cancelButton.layer.addBorder([.top], color: .lightGray, width: 1.0)
        if let alertInfo = alertInformations {
            setSettings(by: alertInfo, color: color)
            
        }
        if isOnlySecondTextColored {
            onlySecondItemColor()
        }
    }
    
    func onlySecondItemColor() {
        secondItemLabel.textColor = secondColor
    }
    func setSettings(by settings: AlertLabels, color: UIColor?) {
        firstItemImageView.image = UIImage(named: "\(settings.icons[0])")
        firstItemLabel.text = settings.names[0]
        secondItemImageView.image = UIImage(named: settings.icons[1])
        secondItemLabel.text = settings.names[1]
        
        if let c = color {
            firstItemLabel.textColor = c
            secondItemLabel.textColor = c
        }
    }
    
    @IBAction func dismissButtonTapped(_ sender: Any) {
        
        NotificationCenter.default.post(name: .init("closePopupNoti"), object: nil)
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func firstItemTapped(_ sender: UIButton) {
        
        if firstItemLabel.text == AlertLabels.myComment.names[0] {
            NotificationCenter.default.post(name: .init("closePopupNoti"), object: nil, userInfo: ["action": "commentPut"])
            
            
        } else if firstItemLabel.text == AlertLabels.otherCommentNotMyArticle.names[0] {
            NotificationCenter.default.post(name: .init("closePopupNoti"), object: nil, userInfo: ["action": "report"])
        }
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func secondItemTapped(_ sender: Any) {
        print("FirstTapped")
        if secondItemLabel.text == AlertLabels.myComment.names[1] {
            NotificationCenter.default.post(name: .init("closePopupNoti"), object: nil, userInfo: ["action": "commentDelete"])
        } else if secondItemLabel.text == AlertLabels.otherCommentNotMyArticle.names[1] {
            NotificationCenter.default.post(name: .init("closePopupNoti"), object: nil, userInfo: ["action": "block"])
        }
        self.dismiss(animated: true, completion: nil)
    }
    
}
