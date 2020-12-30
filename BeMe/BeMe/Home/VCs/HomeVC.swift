//
//  HomeVC.swift
//  BeMe
//
//  Created by Yunjae Kim on 2020/12/28.
//

import UIKit
import Then
import SnapKit

class HomeVC: UIViewController {
    //MARK:- IBOutlets
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var cardCollectionView: UICollectionView!

    
    let alertHorizontalSeperator = UIView().then{
        $0.backgroundColor = .gray
        
    }
    let alertVerticalSeperator = UIView().then {
        $0.backgroundColor = .gray
    }
    
    //MARK:- User Define Variables
    private var cardWidth = 0
    private var pastCards = 0
    private var todayCards = 0
    private var currentCardIdx = 0
    private var initialScrolled = false
    var nowPos = CGPoint(x: -1.0, y: 0)
    
    var locks = [false,false,false,false,false,false,false,false,]

    
    
    
}


//MARK:- LifeCycle Methods
extension HomeVC {
    override func viewDidLoad() {
        super.viewDidLoad()
        pastCards = 3
        todayCards = 1
        cardCollectionView.delegate = self
        cardCollectionView.dataSource = self
        let customLayout = HomeCardCustomFlowLayout()
        cardCollectionView.collectionViewLayout = customLayout
        //        cardCollectionView.reloadData()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        if initialScrolled == false {
            cardCollectionView.scrollToItem(at: IndexPath(item: pastCards, section: 0),
                                            at: .centeredHorizontally,
                                            animated: false)
            initialScrolled = true
            currentCardIdx = pastCards + todayCards - 1
        }
        
        
    }
    
    
    
    
}
//MARK:- User Define functions
extension HomeVC {
    
    @objc func cancelButtonAction(){
        print("called")
        
    }
    
    @objc func okayButtonAction(){
        print("called")
        
    }
    
    func changeLock(){
        locks[currentCardIdx] = !locks[currentCardIdx]
        cardCollectionView.reloadData()
            
    }
    
    func makeAlertTitle() -> String {
        if locks[currentCardIdx] == false {
            return "공개 질문으로 전환하시겠어요?"
        }
        else{
            return "비공개 질문으로 전환하시겠어요?"
        }
        
    }
    
    
}

extension HomeVC : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.item >= pastCards && indexPath.item <= pastCards + todayCards - 1{
            
            guard let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: NewCardCVC.identifier,
                    for: indexPath) as? NewCardCVC else {return UICollectionViewCell()}
            cell.setLock(after: locks[indexPath.item])
            cell.changePublicDelegate = self
            return cell
        }
        
        else if indexPath.item < pastCards {
            guard let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: PastCardCVC.identifier,
                    for: indexPath) as? PastCardCVC else {return UICollectionViewCell()}
            cell.setLock(after: locks[indexPath.item])
            cell.changePublicDelegate = self
            return cell
        }
        else{
            guard let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: AddCardCVC.identifier,
                    for: indexPath) as? AddCardCVC else {return UICollectionViewCell()}
            
            cell.addDelegate = self
            return cell
            
        }
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return pastCards + todayCards + 1
    }
    
    
}




extension HomeVC : UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        cardWidth = Int(collectionView.frame.width)
        return CGSize(width: 315.0 ,
                      height: collectionView.frame.height)
    }
    
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 20, bottom: 0, right:20)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 20
        
    }
    
    
    
}

extension HomeVC : UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let curPos = scrollView.contentOffset
        if Int(curPos.x) < (pastCards-1)*cardWidth {
            timeLabel.text = "과거의 질문"
        }
        else{
            timeLabel.text = "오늘의 질문"
            
        }
        
        if initialScrolled == true{
            
            if Int(curPos.x) < 325 + 335*(currentCardIdx-1) - 200 {
                cardCollectionView.scrollToItem(at: IndexPath(item: currentCardIdx-1, section: 0),
                                                at: .centeredHorizontally,
                                                animated: true)
                currentCardIdx = currentCardIdx-1
                
               
            }
            else if Int(curPos.x) > 325 + 335*(currentCardIdx-1) + 200{
                cardCollectionView.scrollToItem(at: IndexPath(item: currentCardIdx+1, section: 0),
                                                at: .centeredHorizontally,
                                                animated: true)
                currentCardIdx = currentCardIdx+1
                
                
            }
           
        }
      
     
    
        
        
    }
    
    
    
    
}

extension HomeVC : AddQuestionDelegate {
    func addQuestion() {
//        UIView.animate(withDuration: 0.5, animations: {
//            self.todayCards = self.todayCards + 1
//
//            self.cardCollectionView.alpha = 0
//
//        }, completion: { finished in
//            self.cardCollectionView.reloadData()
//            UIView.animate(withDuration: 0.5, animations: {
//                self.cardCollectionView.alpha = 1
//            })
//
//        })
//
        todayCards = todayCards+1
        cardCollectionView.reloadData()
        self.cardCollectionView.scrollToItem(at: IndexPath(item: self.currentCardIdx+1, section: 0),
                                        at: .centeredHorizontally,
                                        animated: false)
        UIView.animate(withDuration: 0.0, animations: {

            
        }, completion: { finished in
            UIView.animate(withDuration: 0.5, animations: {
                
                let move = CGPoint(x:  325 + 335*(self.currentCardIdx-1)-250, y: 0)
                self.cardCollectionView.setContentOffset(move, animated: false)
               
               
                
            })
            
        })
       
        
        
        
    }
    
}
    

extension HomeVC : ChangePublicDelegate{
    func changePublic(now: Bool) {
        
        showAlert(now: now)
        
        
    }
    
    
    func showAlert(now : Bool){
        let blurView = UIView(frame: .zero).then{
            $0.backgroundColor = UIColor(cgColor: CGColor(red: 0, green: 0, blue: 0, alpha: 0.6))
            
        }
        
        let alertView = CustomAlertView(frame: .zero)
        
        self.view.addSubview(blurView)
        self.view.addSubview(alertView)
        
        alertView.setTitles(titleLabel: makeAlertTitle(),
                            leftButtonTitle: "취소",
                            rightButtonTitle: "확인")
        
        
        blurView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
        
        alertView.snp.makeConstraints {
            $0.width.equalTo(270)
            $0.height.equalTo(122)
            $0.centerX.centerY.equalToSuperview()
        }
        
        alertView.leftButtonClicked = { [weak self] in
            blurView.removeFromSuperview()
            alertView.removeFromSuperview()
            
        }
        alertView.rightButtonClicked = { [weak self] in
            self?.changeLock()
            blurView.removeFromSuperview()
            alertView.removeFromSuperview()
        }
        
        
    }
    
    
}



protocol AddQuestionDelegate{
    
    func addQuestion()
    
    
}

protocol ChangePublicDelegate{
    
    func changePublic(now : Bool)
    
}
