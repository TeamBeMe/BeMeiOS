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
    var profileEditDelegate: ProfileEditDelegate?
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
    
        print(indexPath)
        
//        NotificationCenter.default.post(name: .myPageUpdate, object: nil)
        if (self.delegate?.nowDirection() == 0){
            guard let tab = tableView
                    .dequeueReusableCell(withIdentifier: MypageResultTVC.identifier, for: indexPath)
                    as? MypageResultTVC else { return UITableViewCell() }
            if (myAnswerArray.count != 0){
                tab.setCardView(question: myAnswerArray[indexPath.row].question, questionInfo: myAnswerArray[indexPath.row].category, answerDate: myAnswerArray[indexPath.row].answerDate, isLocked: !myAnswerArray[indexPath.row].publicFlag)
                
                tab.isLocked = !myAnswerArray[indexPath.row].publicFlag
                tab.answerIdx = myAnswerArray[indexPath.row].id
                tab.delegate = self
                tab.indexpath = indexPath.row
                tab.selectionStyle = .none
            }
            tab.answerID = myAnswerArray[indexPath.row].id
            tab.profileEditDelegate = self
            return tab
        } else {
            
            if (myScrapArray.count != 0){
                if (myScrapArray[indexPath.item].isAuthor){
                    guard let tab = tableView
                            .dequeueReusableCell(withIdentifier: MypageMyScrapTVC.identifier, for: indexPath)
                            as? MypageMyScrapTVC else { return UITableViewCell() }
                    
                    tab.setCardView(question: myScrapArray[indexPath.row].question, questionInfo: myScrapArray[indexPath.row].category, answerDate: myScrapArray[indexPath.row].answerDate, isLocked: !myScrapArray[indexPath.row].publicFlag, isScrapped: myScrapArray[indexPath.row].isScrapped!)
                    tab.selectionStyle = .none
                    tab.profileEditDelegate = self
                    tab.answerID = myScrapArray[indexPath.item].id
                    return tab
                    
                }else {
                    guard let tab = tableView
                            .dequeueReusableCell(withIdentifier: MypageOthersScrapTVC.identifier, for: indexPath)
                            as? MypageOthersScrapTVC else { return UITableViewCell() }
                    
                    tab.setCardView(question: myScrapArray[indexPath.row].question, questionInfo: myScrapArray[indexPath.row].category, answerDate: myScrapArray[indexPath.row].answerDate, writer: myScrapArray[indexPath.row].userNickname, writerImg: myScrapArray[indexPath.row].userProfile!, isScrapped: myScrapArray[indexPath.row].isScrapped!)
                    tab.selectionStyle = .none
                    tab.answerID = myScrapArray[indexPath.row].id
                    tab.profileEditDelegate = self
                    return tab
                    
                }
            } else {
                guard let tab = tableView
                        .dequeueReusableCell(withIdentifier: MypageMyScrapTVC.identifier, for: indexPath)
                        as? MypageMyScrapTVC else { return UITableViewCell() }
                tab.answerID = myScrapArray[indexPath.row].id
                tab.profileEditDelegate = self
                return tab
            }
        }
        
    }
    
    
}

extension MypageTabCVC: MypageResultTVCDelegate {
    func reload(indexpath: Int) {
        myAnswerArray[indexpath].publicFlag = !myAnswerArray[indexpath].publicFlag
        profileEditDelegate?.showToast(showBool: !myAnswerArray[indexpath].publicFlag)
        mypageTableView.reloadData()
        
    }
    
}

extension MypageTabCVC {
    
    func checkShouldUpdate()-> Bool{
        for cell in mypageTableView.visibleCells {
            if let myindexPath = mypageTableView.indexPath(for: cell){
                print(myindexPath)
                if myindexPath.row >= myAnswerArray.count - 1 {
                    return true
                }
                
            }
            
        }
        
        return false
    }
}

extension MypageTabCVC: ProfileEditDelegate{
    
    func profileEdit(){
        
        
    }
    func cardTapped(answerID: Int){
        profileEditDelegate?.cardTapped(answerID: answerID)
    }
    func showToast(showBool: Bool){
        profileEditDelegate?.showToast(showBool: showBool)
        
    }
}
