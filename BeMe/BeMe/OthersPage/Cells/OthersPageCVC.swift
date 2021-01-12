//
//  OthersPageCVC.swift
//  BeMe
//
//  Created by 박세란 on 2021/01/09.
//

import UIKit

class OthersPageCVC: UICollectionViewCell {
    //MARK:**- IBOutlet Part**
    @IBOutlet weak var otherspageTableView: UITableView!
    
    //MARK:**- Variable Part**
    static let identifier = "OthersPageCVC"
//    private var cellNumber: Int = 8
    var othersAnswerArray: [Answer] = []
    
    
    //MARK:**- Life Cycle Part**
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        tableViewSetting()
        print("--------")
    }
    
    
    //MARK:**- IBAction Part**
    
    //MARK:**- default Setting Function Part**
    func tableViewSetting()
    {
        otherspageTableView.delegate = self
        otherspageTableView.dataSource = self
        otherspageTableView.separatorStyle = .none
    }
    //MARK:**- Function Part**
    
}

//MARK:**- extension 부분**
extension OthersPageCVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return othersAnswerArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let tab = tableView
                .dequeueReusableCell(withIdentifier: OthersPageTVC.identifier, for: indexPath)
                as? OthersPageTVC else { return UITableViewCell() }

//        tab.setCardView(question: "cell.layer.cornerRadius = cell.bounds.width / cell.bounds.height * 10cell.layer.cornerRadius = cell.bounds.width / cell.bounds.height * 10cell.layer.cornerRadius = cell.bounds.width / cell.bounds.height * 10", questionInfo: "serysery 1", answerDate: "2020.20.20", writer: "ㄴㄷ교270", writerImg: "icDeclare", isScrapped: false)
        
        
        tab.setCardView(question: othersAnswerArray[indexPath.row].question, questionInfo: othersAnswerArray[indexPath.row].category, answerDate: othersAnswerArray[indexPath.row].answerDate, writer: othersAnswerArray[indexPath.row].userNickname, writerImg: "icDeclare", isScrapped: othersAnswerArray[indexPath.row].isScrapped)
        
        print("dsfasdfa ")
        print(othersAnswerArray.count)
        return tab

    }
    
   
}


