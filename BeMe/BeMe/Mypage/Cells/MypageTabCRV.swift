//
//  MypageTabCRV.swift
//  BeMe
//
//  Created by 박세란 on 2021/01/05.
//

import UIKit

class MypageTabCRV: UICollectionReusableView {
    //MARK:**- IBOutlet Part**

    @IBOutlet weak var myAnswerButton: UIButton!
    @IBOutlet weak var scrappedAnswerButton: UIButton!
    @IBOutlet weak var highLightBar: UIView!
    @IBOutlet weak var keywordLabel: UILabel!
    
    
    //MARK:**- Variable Part**
    static let identifier = "MypageTabCRV"
    
    //MARK:**- Life Cycle Part**
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    //MARK:**- IBAction Part**
    
    @IBAction func filterButtonTapped(_ sender: Any) {
    }
    
    //MARK:**- default Setting Function Part**
    
    //MARK:**- Function Part**
}
