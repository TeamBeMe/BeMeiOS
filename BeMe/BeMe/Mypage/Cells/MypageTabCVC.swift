//
//  MypageTabCVC.swift
//  BeMe
//
//  Created by 박세란 on 2021/01/05.
//

import UIKit

class MypageTabCVC: UICollectionViewCell {
    //MARK:**- IBOutlet Part**
    @IBOutlet weak var mypageTableView: UITableView!
    
    @IBOutlet weak var myPageTVHeight: NSLayoutConstraint!
    //MARK:**- Variable Part**
    static let identifier = "MypageTabCVC"
    var myAnswerArray: [Answer] = []
    var myScrapArray: [Answer] = []
    var delegate: MypageCVCDelegate?
    
    
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
        mypageTableView.delegate = self
        mypageTableView.dataSource = self
        mypageTableView.separatorStyle = .none
    }
    //MARK:**- Function Part**
    
}

//MARK:**- extension 부분**
extension MypageTabCVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (self.delegate?.nowDirection() == 0){
            return myAnswerArray.count
        } else {
            return myScrapArray.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let tab = tableView
                .dequeueReusableCell(withIdentifier: MypageResultTVC.identifier, for: indexPath)
                as? MypageResultTVC else { return UITableViewCell() }
        if (self.delegate?.nowDirection() == 0){
            if (myAnswerArray.count != 0){
    //            print(indexPath.row)
                print("tableView myAnswerArray")
                tab.setCardView(question: myAnswerArray[indexPath.row].question, questionInfo: myAnswerArray[indexPath.row].category, answerDate: myAnswerArray[indexPath.row].answerDate, isLocked: myAnswerArray[indexPath.row].publicFlag)
            }
        } else {
            if (myScrapArray.count != 0){
    //            print(indexPath.row)
                print("tableView myScrapArray")
                tab.setCardView(question: myScrapArray[indexPath.row].question, questionInfo: myScrapArray[indexPath.row].category, answerDate: myScrapArray[indexPath.row].answerDate, isLocked: myScrapArray[indexPath.row].publicFlag)
            }
        }
        
//        tab.delegate = self

        return tab

    }
    
   
}


