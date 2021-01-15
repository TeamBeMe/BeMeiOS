//
//  MypageCVC.swift
//  BeMe
//
//  Created by 박세란 on 2021/01/05.
//

import UIKit

class MypageCVC: UICollectionViewCell {
    //MARK:**- IBOutlet Part**
    @IBOutlet weak var mypageTabCollectionView: UICollectionView!
    var mypageCVCDelegate: MypageCVCDelegate?
    var profileEditDelegate: ProfileEditDelegate?
    
    //MARK:**- Variable Part**
    static let identifier = "MypageCVC"
    private var cellNumber: Int = 2
    
    var myAnswerArray: [Answer] = []
    var myScrapArray: [Answer] = []
    var tableviewHeight: CGFloat = 735.0
    
    //MARK:**- Life Cycle Part**
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        collectionViewSetting()
    }
    
    
    //MARK:**- IBAction Part**
    
    //MARK:**- default Setting Function Part**
    func collectionViewSetting()
    {
        mypageTabCollectionView.delegate = self
        mypageTabCollectionView.dataSource = self
        
    }
    
    //MARK:**- Function Part**
    
    func scrollDirection(by direction: Int) {
        if (direction == 0) {
            mypageTabCollectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .right, animated: true)
        } else {
            mypageTabCollectionView.scrollToItem(at: IndexPath(item: 1, section: 0), at: .left, animated: true)
        }
    }
}

//MARK:**- extension 부분**


extension MypageCVC : UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
}

extension MypageCVC : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellNumber
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: MypageTabCVC.identifier,
                for: indexPath) as? MypageTabCVC else {
            
            return UICollectionViewCell()}
        cell.myAnswerArray = myAnswerArray
        cell.myScrapArray = myScrapArray
        cell.mypageTableView.reloadData()
        cell.delegate = mypageCVCDelegate
        cell.profileEditDelegate = self
        return cell        
    }
    
}

extension MypageCVC : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        if mypageCVCDelegate?.nowDirection() == 0 {
            tableviewHeight = (CGFloat(myAnswerArray.count) * 105.0 > 0) ? CGFloat(myAnswerArray.count) * 105.0 : 735
        } else {
            tableviewHeight = (CGFloat(myScrapArray.count) * 105.0 > 0) ? CGFloat(myScrapArray.count) * 105.0 : 735
        }
        
        tableviewHeight = (tableviewHeight < 588.0) ? 588 : tableviewHeight
        
        
        return CGSize(width: collectionView.frame.width  , height: tableviewHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    //    UIEdgeInset
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
        
    }
    
}

extension MypageCVC: ProfileEditDelegate{
    
    func profileEdit(){
        
        
    }
    func cardTapped(answerID: Int){
        profileEditDelegate?.cardTapped(answerID: answerID)
    }
    func showToast(showBool: Bool){
        profileEditDelegate?.showToast(showBool: showBool)
        
    }
}


protocol MypageCVCDelegate {

    func myAnswerItem()
    func myScrapItem()
    func nowDirection() -> Int
}

