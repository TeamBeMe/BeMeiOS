//
//  MypageSearchTVC.swift
//  BeMe
//
//  Created by 박세란 on 2021/01/03.
//

import UIKit

class MypageSearchTVC: UITableViewCell {
    
    //MARK:**- IBOutlet Part**
    
    @IBOutlet weak var searchButton: UIButton!
    
    @IBOutlet weak var keywordLabel: UILabel!
    
    //MARK:**- Variable Part**
    
    lazy var identifier: String = "MypageSearchTVC"
    
    
    
    
    //MARK:**- Life Cycle Part**
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setSearhButton(view: searchButton)
        setKeywordLabel(label: keywordLabel)
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
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
    
    
}
