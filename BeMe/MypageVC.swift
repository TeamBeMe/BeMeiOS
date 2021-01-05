//
//  MypageVC.swift
//  BeMe
//
//  Created by 박세란 on 2021/01/03.
//

import UIKit

class MypageVC:UIViewController {
    
    //MARK:**- IBOutlet Part**

    
    //MARK:**- Variable Part**
    
    //MARK:**- Constraint Part**
    
    //MARK:**- Life Cycle Part**
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
//        setSearhButton(view: searchButton)
//        setKeywordLabel(label: keywordLabel)
        
    }
    
    //MARK:**- IBAction Part**
    
    @IBAction func searchButtonTapped(_ sender: Any) {
    }
    
    @IBAction func deleteButtonTapped(_ sender: Any) {
    }
    
    @IBAction func filterButtonTapped(_ sender: Any) {
    }
    
    
    //MARK:**- default Setting Function Part**
    
    
    func setSearhButton(view: UIButton) {
        view.setBorderWithRadius(borderColor: .veryLightPinkTwo, borderWidth: 1, cornerRadius: 6)
        view.backgroundColor = UIColor.veryLightPinkTwo
    }
    
    
    // 아래 두 함수는 TVC 뿐만 아니라 여러 곳에서 사용가능
    // 검색어를 삭제했거나 , 초기 화면
    func setKeywordLabel(label : UILabel){
        label.text = "검색"
        label.textColor = UIColor.rgb8E8E93
    }
    
    // 검색 결과 후
    func setKeywordLabel( label : UILabel, keyword: String){
        label.text = keyword
        label.textColor = UIColor.darkGray
        
    }
    
    
    //MARK:**- Function Part**
    
    
    //MARK:**- extension 부분**
    
    
}
