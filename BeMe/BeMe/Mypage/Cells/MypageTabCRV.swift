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
    @IBOutlet weak var searchView: UIButton!
    
    
    //MARK:**- Variable Part**
    static let identifier = "MypageTabCRV"
    
    //MARK:**- Life Cycle Part**
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setSearhView(view: searchView)
        setKeywordLabel(label: keywordLabel ,keyword: "데헷데헷밍")
    }
    
    
    //MARK:**- IBAction Part**
    
    @IBAction func filterButtonTapped(_ sender: Any) {
    }
    
    @IBAction func deleteButtonTapped(_ sender: Any) {
    }
    
    @IBAction func myAswerButtonTapped(_ sender: Any) {
    }
    @IBAction func scrappedAswerButtonTapped(_ sender: Any) {
    }
    
    //MARK:**- default Setting Function Part**
    func setSearhView(view: UIView) {
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
