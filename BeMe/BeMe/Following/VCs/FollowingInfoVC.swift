//
//  FollowingInfoVC.swift
//  BeMe
//
//  Created by Yunjae Kim on 2020/12/30.
//

import UIKit

class FollowingInfoVC: UIViewController {

    @IBOutlet weak var wholeCollectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        wholeCollectionView.delegate = self
        wholeCollectionView.dataSource = self
        
    }
    
    
    

    
    
    

}

extension FollowingInfoVC : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.item == 0{
            guard let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: FollowingPeopleCVC.identifier,
                    for: indexPath) as? FollowingPeopleCVC else {return UICollectionViewCell()}
            
            
            return cell
            
        }
        else if indexPath.item == 1{
            guard let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: FollowingHeaderCVC.identifier,
                    for: indexPath) as? FollowingHeaderCVC else {return UICollectionViewCell()}
            
            
            return cell
            
        }
        
        else {
            guard let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: FollowingCardCVC.identifier,
                    for: indexPath) as? FollowingCardCVC else {return UICollectionViewCell()}
            
            
            return cell
            
        }
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    
}




extension FollowingInfoVC : UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.item == 0 {
            return CGSize(width: collectionView.frame.width , height: 150)
            
        }
        else if indexPath.item == 1{
            return CGSize(width: collectionView.frame.width , height: 80)
        }
        else {
            return CGSize(width: collectionView.frame.width  , height: 313)
            
        }
      
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right:0)
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
