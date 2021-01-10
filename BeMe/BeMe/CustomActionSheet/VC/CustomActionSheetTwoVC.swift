//
//  CustomActionSheetTwoVC.swift
//  BeMe
//
//  Created by 이재용 on 2021/01/07.
//

import UIKit

class CustomActionSheetTwoVC: UIViewController {
    static let identifier: String = "CustomActionSheetTwoVC"
    
    @IBOutlet weak var firstItemImageView: UIImageView!
    @IBOutlet weak var firstItemLabel: UILabel!
    @IBOutlet weak var secondItemImageView: UIImageView!
    @IBOutlet weak var secondeItemLabel: UILabel!
    
    
    var alertInformations: AlertLabels?
    
    var color: UIColor?
    
    var isOnlySecondTextColored: Bool = false
    
    var secondColor: UIColor?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print("seconde")
        if let alertInfo = alertInformations {
            setSettings(by: alertInfo, color: color)
            
        }
        if isOnlySecondTextColored {
            onlySecondItemColor()
        }
    }
    
    func onlySecondItemColor() {
        secondeItemLabel.textColor = secondColor
    }
    func setSettings(by settings: AlertLabels, color: UIColor?) {
        firstItemImageView.image = UIImage(named: "\(settings.icons[0])")
        firstItemLabel.text = settings.names[0]
        secondItemImageView.image = UIImage(named: settings.icons[1])
        secondeItemLabel.text = settings.names[1]
        
        if let c = color {
            firstItemLabel.textColor = c
            secondeItemLabel.textColor = c
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
        
        self.dismiss(animated: true, completion: nil)
    }
    
}
