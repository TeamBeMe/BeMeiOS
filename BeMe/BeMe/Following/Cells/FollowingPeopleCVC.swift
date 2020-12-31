//
//  FollowingPeopleCVC.swift
//  BeMe
//
//  Created by Yunjae Kim on 2020/12/30.
//

import UIKit

class FollowingPeopleCVC: UICollectionViewCell {
    static let identifier : String = "FollowingPeopleCVC"
    
    //MARK:- IBOutlets
    @IBOutlet weak var peopleCollectionVIew: UICollectionView!
    
    
    override func awakeFromNib() {
        peopleCollectionVIew.delegate = self
        peopleCollectionVIew.dataSource = self
        
    }
    
    
}


extension FollowingPeopleCVC : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: FollowingPersonCVC.identifier,
                for: indexPath) as? FollowingPersonCVC else {return UICollectionViewCell()}
        
        
        return cell
            
        
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return 8
    }
    
    
}




extension FollowingPeopleCVC : UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
       
        return CGSize(width: 58  , height: 100)
            
        
      
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 20, bottom: 0, right:0)
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
