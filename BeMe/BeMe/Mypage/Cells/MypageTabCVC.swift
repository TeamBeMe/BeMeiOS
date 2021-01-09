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
    
    @IBOutlet weak var myPageTVHeight: NSLayoutConstraint!
    //MARK:**- Variable Part**
    static let identifier = "MypageTabCVC"
    private var cellNumber: Int = 8
    
    
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
        MypageTV.delegate = self
        MypageTV.dataSource = self
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
        
        guard let tab = tableView
                .dequeueReusableCell(withIdentifier: MypageResultTVC.identifier, for: indexPath)
                as? MypageResultTVC else { return UITableViewCell() }
        tab.setCardView(question: "cell.layer.cornerRadius = cell.bounds.width / cell.bounds.height * 10cell.layer.cornerRadius = cell.bounds.width / cell.bounds.height * 10cell.layer.cornerRadius = cell.bounds.width / cell.bounds.height * 10", questionInfo: "아요 1000번째 경험", answerDate: "아요 1번째 경험", isLocked: true)
        

        return tab

    }
    
   
}


