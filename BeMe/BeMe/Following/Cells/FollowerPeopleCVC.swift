//
//  FollowerPeopleCVC.swift
//  BeMe
//
//  Created by Yunjae Kim on 2020/12/30.
//

import UIKit

class FollowerPeopleCVC: UICollectionViewCell {
    static let identifier : String = "FollowerPeopleCVC"
    
    
    @IBOutlet weak var peopleCollectionView: UICollectionView!
    
    override func awakeFromNib() {
        peopleCollectionView.delegate = self
        peopleCollectionView.dataSource = self
        
    }
    
    
}


extension FollowerPeopleCVC : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: FollowerPersonCVC.identifier,
                for: indexPath) as? FollowerPersonCVC else {return UICollectionViewCell()}
        
        
        return cell
            
        
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return 8
    }
    
    
}




extension FollowerPeopleCVC : UICollectionViewDelegateFlowLayout {
    
    
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
