//
//  CustomActionSheet.swift
//  BeMe
//
//  Created by 이재용 on 2021/01/03.
//

import UIKit

class CustomActionSheetVC: UIViewController {
    
    static let identifier: String = "CustomActionSheetVC"
    
    @IBOutlet weak var wrapper: UIView!
    @IBOutlet weak var stackView: UIStackView!
    
    @IBOutlet weak var firstIcon: UIImageView!
    @IBOutlet weak var firstLabel: UILabel!
    
    @IBOutlet weak var secondIcon: UIImageView!
    @IBOutlet weak var secondLabel: UILabel!
    
    @IBOutlet weak var thirdIcon: UIImageView!
    @IBOutlet weak var thirdLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stackView.layer.addBorder([.bottom], color: .lightGray, width: 1.0)
        wrapper.roundCorners(cornerRadius: 10.0)
    }
    
    @IBAction func closeButtonTapped(_ sender: UIButton) {
        NotificationCenter.default.post(name: .init("closePopupNoti"), object: nil)
        self.dismiss(animated: true, completion: nil)
    }
    
    func setSettings(icons: [String], names: [String]) {
        firstIcon.image = UIImage(named: icons[0])
        firstLabel.text = names[0]
        secondIcon.image = UIImage(named: icons[1])
        secondLabel.text = names[1]
        thirdIcon.image = UIImage(named: icons[2])
        thirdLabel.text = names[2]
        
    }
}

extension CALayer {
    func addBorder(_ arr_edge: [UIRectEdge], color: UIColor, width: CGFloat) {
        for edge in arr_edge {
            let border = CALayer()
            switch edge {
            case UIRectEdge.top:
                border.frame = CGRect.init(x: 0, y: 0, width: frame.width, height: width)
                break
            case UIRectEdge.bottom:
                border.frame = CGRect.init(x: 0, y: frame.height - width, width: frame.width, height: width)
                break
            case UIRectEdge.left:
                border.frame = CGRect.init(x: 0, y: 0, width: width, height: frame.height)
                break
            case UIRectEdge.right:
                border.frame = CGRect.init(x: frame.width - width, y: 0, width: width, height: frame.height)
                break
            default:
                break
            }
            border.backgroundColor = color.cgColor;
            self.addSublayer(border)
        }
    }
}
