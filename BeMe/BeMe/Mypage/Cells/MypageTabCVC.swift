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
        
        if indexPath.row == 0 {
            guard let tab = tableView
                    .dequeueReusableCell(withIdentifier: MypageResultTVC.identifier, for: indexPath)
                    as? MypageResultTVC else { return UITableViewCell() }
            tab.setCardView(question: "cell.layer.cornerRadius = cell.bounds.width / cell.bounds.height * 10cell.layer.cornerRadius = cell.bounds.width / cell.bounds.height * 10cell.layer.cornerRadius = cell.bounds.width / cell.bounds.height * 10", questionInfo: "아요 1000번째 경험", answerDate: "아요 1번째 경험", isLocked: true)
            

            return tab
        } else if indexPath.row == 1 {
            guard let scrap = tableView
                    .dequeueReusableCell(withIdentifier: MypageMyScrapTVC.identifier, for: indexPath)
                    as? MypageMyScrapTVC else { return UITableViewCell() }
            scrap.setCardView(question: "dbnd`", questionInfo: "아요 1번째 경험", answerDate: "202020202", isLocked:true ,isScrapped: true)
            
            return scrap
        } else {
            guard let scrap = tableView
                    .dequeueReusableCell(withIdentifier: MypageOthersScrapTVC.identifier, for: indexPath)
                    as? MypageOthersScrapTVC else { return UITableViewCell() }
            scrap.setCardView(question: "아요 1000번째 경험아요 1000번째 경험아요 1000번째 경험아요 1000번째 경험아요 1000번째 경험아요 1000번째 경험아요 1000번번째 경험아요 1000번째 경험아요 1000번째 경험아요 1000번째 경험아요 1000번째 경험dbnd`", questionInfo: "아요 1번째 경험", answerDate: "202020202", writer: "재용아 맥주 그만 마셔", writerImg: "imgProfile66", isScrapped: true)
            
            return scrap
        }
        
        
        
        
    }
    
   
}


