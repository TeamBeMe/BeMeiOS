//
//  MypageTabCVC.swift
//  BeMe
//
//  Created by 박세란 on 2021/01/05.
//

import UIKit

class MypageTabCVC: UICollectionViewCell {
    //MARK:**- IBOutlet Part**
    @IBOutlet weak var MypageTV: UITableView!
    
    //MARK:**- Variable Part**
    static let identifier = "MypageTabCVC"
    private var cellNumber: Int = 2
    
    
    //MARK:**- Life Cycle Part**
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        tableViewSetting()
    }
    
    
    //MARK:**- IBAction Part**
    
    //MARK:**- default Setting Function Part**
    func tableViewSetting()
    {
        MypageTV.delegate = self.MypageTV.delegate
        MypageTV.dataSource = self.MypageTV.dataSource
        MypageTV.separatorStyle = .none

    }
    //MARK:**- Function Part**
    
}

//MARK:**- extension 부분**
extension MypageTabCVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellNumber
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            guard let tab = tableView
                    .dequeueReusableCell(withIdentifier: MypageResultTVC.identifier, for: indexPath)
                    as? MypageResultTVC else { return UITableViewCell() }

            return tab
        } else {
            guard let scrap = tableView
                    .dequeueReusableCell(withIdentifier: MypageResultTVC.identifier, for: indexPath)
                    as? MypageResultTVC else { return UITableViewCell() }
            
            return scrap
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 62
        } else if indexPath.row == cellNumber - 1 {
            return UITableView.automaticDimension
        } else {
            return UITableView.automaticDimension
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if indexPath.row == 0 {
            // no animation
            
        } else if indexPath.row == cellNumber - 1 {
            // animation 2
            cell.alpha = 0
            UIView.animate(withDuration: 0.75) {
                
                cell.alpha = 1.0
            }
        } else {
            // animation 1
            let rotationTransform = CATransform3DTranslate(CATransform3DIdentity, 0, 320, 0)
            cell.layer.transform = rotationTransform
            cell.alpha = 0.5
            
            UIView.animate(withDuration: 0.5, delay: 0, options: [.curveEaseInOut], animations: {
                cell.layer.transform = CATransform3DIdentity
                cell.alpha = 1.0
            }) { (_) in
                
            }
            
        }
        
    }
}
