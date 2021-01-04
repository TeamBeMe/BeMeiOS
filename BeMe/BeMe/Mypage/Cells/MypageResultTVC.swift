//
//  MypageResultTVC.swift
//  BeMe
//
//  Created by 박세란 on 2021/01/03.
//

import UIKit

class MypageResultTVC: UITableViewCell {
    
    //MARK:**- IBOutlet Part**

    /// Label, ColelctionView, TextField, ImageView 등 @IBOutlet 변수들을 선언합니다.  // 변수명 lowerCamelCase 사용

    /// ex)  @IBOutlet weak var qnaTextBoxBackgroundImage: UIImageView!

    //MARK:**- Variable Part**

    /// 뷰컨에 필요한 변수들을 선언합니다  // 변수명 lowerCamelCase 사용

    /// ex)  var imageViewList : [UIImageView] = []
    
    //MARK:**- Life Cycle Part**

    /// 앱의 Life Cycle 부분을 선언합니다

    /// ex) override func viewWillAppear() { }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    //MARK:**- IBAction Part**

    /// 버튼과 같은 동작을 선언하는 @IBAction 을 선언합니다 , IBAction 함수 명은 동사 형태로!!  // 함수명 lowerCamelCase 사용

    /// ex) @IBOutlet @IBAction func answerSelectedButtonClicked(_ sender: Any) { }

    //MARK:**- default Setting Function Part**

    /// 기본적인 세팅을 위한 함수 부분입니다 // 함수명 lowerCamelCase 사용

    /// ex) func tableViewSetting() {

    ///         myTableView.delegate = self

    ///         myTableView.datasource = self

    ///    }

    //MARK:**- Function Part**

    /// 로직을 구현 하는 함수 부분입니다. // 함수명 lowerCamelCase 사용

    /// ex) func tableViewSetting() {

    ///         myTableView.delegate = self

    ///         myTableView.datasource = self

    ///    }

}
