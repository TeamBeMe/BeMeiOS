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
