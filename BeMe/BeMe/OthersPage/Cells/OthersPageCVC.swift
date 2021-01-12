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
    var othersAnswerArray: [Answer] = []
    var tableviewHeight: CGFloat = 0.0

    //MARK:**- Life Cycle Part**
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        tableViewSetting()
        tableviewHeight = 0.0
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
        
        tab.setCardView(question: othersAnswerArray[indexPath.row].question, questionInfo: othersAnswerArray[indexPath.row].category, answerDate: othersAnswerArray[indexPath.row].answerDate, writer: othersAnswerArray[indexPath.row].userNickname, writerImg: othersAnswerArray[indexPath.row].userProfile ?? "", isScrapped: othersAnswerArray[indexPath.row].isScrapped, answerId: othersAnswerArray[indexPath.row].id, questionId: othersAnswerArray[indexPath.row].questionID)
        tab.delegate = self
        print("$$$$$$$$$")
        print(indexPath.row)
        print(othersAnswerArray[indexPath.row].isScrapped)
        
        
        //        tableviewHeight += tableView.estimatedRowHeight
//            
//        print("dsfasdfa ")
//        print(tableviewHeight)
        return tab

    }
    
   
}

extension OthersPageCVC {
    
    private func scrapAnswer(answerId: Int) {
        
        ExploreAnswerScrapService.shared.putExploreAnswerScrap(answerId: answerId) { (result) in
            switch result {
            case .success(let data):
                
                guard let dt = data as? GenericResponse<[ExploreCategory]> else { return }
                print(dt.message)
                if dt.message == "스크랩 성공" {
                    // 사용자한테 성공했다고 알려주는 동작
                } else {
                    // 사용자한테 실패했다고 알려주는 동작
                }
                 
            case .requestErr(let message):
                guard let message = message as? String else { return }
                let alertViewController = UIAlertController(title: "통신 실패", message: message, preferredStyle: .alert)
                let action = UIAlertAction(title: "확인", style: .cancel, handler: nil)
                alertViewController.addAction(action)
//                self.present(alertViewController, animated: true, completion: nil)
                
            case .pathErr: print("path")
            case .serverErr:
                let alertViewController = UIAlertController(title: "통신 실패", message: "서버 오류", preferredStyle: .alert)
                let action = UIAlertAction(title: "확인", style: .cancel, handler: nil)
                alertViewController.addAction(action)
//                self.present(alertViewController, animated: true, completion: nil)
                print("networkFail")
                print("serverErr")
            case .networkFail:
                let alertViewController = UIAlertController(title: "통신 실패", message: "네트워크 오류", preferredStyle: .alert)
                let action = UIAlertAction(title: "확인", style: .cancel, handler: nil)
                alertViewController.addAction(action)
//                self.present(alertViewController, animated: true, completion: nil)
                print("networkFail")
            }
        }
    }
}

extension OthersPageCVC: UITableViewButtonSelectedDelegate {
    
    func exploreAnswerScrapButtonDidTapped(_ answerId: Int) {
        print(answerId)
        print("scrapAnswer 시동 !")
        scrapAnswer(answerId: answerId)

    }
    
}
