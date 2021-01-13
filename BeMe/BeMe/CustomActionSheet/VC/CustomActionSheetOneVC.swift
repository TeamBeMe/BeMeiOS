//
//  CustomActionSheetOneVC.swift
//  BeMe
//
//  Created by 이재용 on 2021/01/14.
//

import UIKit

class CustomActionSheetOneVC: UIViewController {
    static let identifier: String = "CustomActionSheetOneVC"
    @IBOutlet weak var wrapper: UIView!
    @IBOutlet weak var firstItemImageView: UIImageView!
    @IBOutlet weak var firstItemLabel: UILabel!
    @IBOutlet weak var cancelButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        wrapper.roundCorners(cornerRadius: 10.0, maskedCorners: [.layerMaxXMinYCorner, .layerMinXMinYCorner])
        
//        cancelButton.layer.addBorder([.top], color: .lightGray, width: 1.0)
    }
    
    @IBAction func dismissButtonTapped(_ sender: Any) {
        
        NotificationCenter.default.post(name: .init("closePopupNoti"), object: nil)
        self.dismiss(animated: true, completion: nil)
    }
    
    
    func setSettings(by settings: AlertLabels, color: UIColor?) {
        firstItemImageView.image = UIImage(named: "\(settings.icons[0])")
        firstItemLabel.text = settings.names[0]
        
        if let c = color {
            firstItemLabel.textColor = c
        }
    }

    @IBAction func firstItemButtonTapped(_ sender: UIButton) {
        
        if firstItemLabel.text == "신고하기" {
            NotificationCenter.default.post(name: .init("closePopupNoti"), object: nil, userInfo: ["action": "report"])
        }
        
        self.dismiss(animated: true, completion: nil)
    }
}
